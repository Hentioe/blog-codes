use lazy_static::lazy_static;
use std::{cell::LazyCell, collections::HashMap};

type MyMap = HashMap<u32, &'static str>;

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

const LAZY_CELL_MAP: LazyCell<MyMap> = LazyCell::new(|| {
    let mut m = HashMap::new();
    m.insert(0, "foo");
    m.insert(1, "bar");
    m.insert(2, "baz");
    m
});

fn main() {
    println!("lazy_static example: {:?}", *LAZY_STATIC_MAP); // => lazy_static example: {2: "baz", 0: "foo", 1: "bar"}
    println!("lazy_cell example: {:?}", *LAZY_CELL_MAP); // => lazy_cell example: {2: "baz", 0: "foo", 1: "bar"}
}
