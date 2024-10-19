use html5ever::tendril::TendrilSink;
use html5ever::{parse_document, parse_fragment, serialize, QualName};
use markup5ever::{local_name, namespace_url, ns};
use markup5ever_rcdom::{Handle, Node, RcDom, SerializableHandle};
use std::io::Cursor;
use std::rc::Rc;

fn main() {
    let html = "<html><body>Hello, world!<p>Good!</p></body></html>";
    let dom = parse_document(RcDom::default(), Default::default())
        .from_utf8()
        .read_from(&mut Cursor::new(html))
        .unwrap();

    let fragment = "<span>Very <strong>good</strone>!</span>";
    let fragment_dom = parse_fragment(
        RcDom::default(),
        Default::default(),
        QualName::new(None, ns!(html), local_name!("body")),
        vec![],
    )
    .one(fragment);

    let children = find_elements(&fragment_dom.document);

    // modify_text(dom.document.clone());
    replace_children(dom.document.clone(), "p", children);

    // 序列化 DOM 为 HTML 字符串
    let mut buf = Vec::new();
    let document: SerializableHandle = dom.document.clone().into();
    serialize(&mut buf, &document, Default::default()).unwrap();
    let new_html = String::from_utf8(buf).unwrap();

    println!("{}", new_html);
}

fn modify_text(handle: Handle) {
    let node = handle;
    let children = node.children.borrow();
    for child in children.iter() {
        match child.data {
            markup5ever_rcdom::NodeData::Text { ref contents } => {
                contents.replace("What's up?".into());
            }
            _ => modify_text(child.clone()),
        }
    }
}

fn replace_children(handle: Handle, target_tag: &str, new_children: Vec<Rc<Node>>) {
    let node = handle;
    let children = node.children.borrow();
    for child in children.iter() {
        match &child.data {
            markup5ever_rcdom::NodeData::Element { ref name, .. } => {
                // 匹配目标标签
                if name.local.as_ref() == target_tag {
                    child.children.replace(new_children);
                    return;
                } else {
                    replace_children(child.clone(), target_tag, new_children.clone());
                }
            }
            _ => replace_children(child.clone(), target_tag, new_children.clone()),
        }
    }
}

fn find_elements(handle: &Handle) -> Vec<Rc<Node>> {
    let node: &Rc<Node> = handle;
    let children = node.children.borrow();
    if let Some(child) = children.iter().next() {
        match &child.data {
            markup5ever_rcdom::NodeData::Element { ref name, .. } => {
                if name.local.as_ref() == "html" {
                    // 将 child.children 转换为 Vec<Rc<Node>>
                    child.children.borrow().iter().cloned().collect()
                } else {
                    find_elements(child)
                }
            }
            _ => find_elements(child),
        }
    } else {
        panic!("no valid elements found when parsing patch content HTML");
    }
}
