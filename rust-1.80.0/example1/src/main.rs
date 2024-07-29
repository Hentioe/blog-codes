use lazy_static::lazy_static;
use std::{collections::HashMap, sync::LazyLock};

type MyMap = HashMap<u32, &'static str>;

// 用 lazy_static 定义一个全局的 HashMap
#[cfg(feature = "lazy_static")]
lazy_static! {
    static ref LAZY_STATIC_MAP: MyMap = {
        let mut m = HashMap::new();
        m.insert(0, "foo");
        m.insert(1, "bar");
        m.insert(2, "baz");
        m
    };
}

// 用 LazyLock 定义一个全局的 HashMap
static LAZY_CELL_MAP: LazyLock<MyMap> = LazyLock::new(|| {
    let mut m = HashMap::new();
    m.insert(0, "foo");
    m.insert(1, "bar");
    m.insert(2, "baz");
    m
});

fn main() {
    println!("lazy_static example: {:?}", *LAZY_STATIC_MAP); // => lazy_static example: {2: "baz", 0: "foo", 1: "bar"}
    println!("lazy_lock example: {:?}", *LAZY_CELL_MAP); // => lazy_cell example: {2: "baz", 0: "foo", 1: "bar"}
}
