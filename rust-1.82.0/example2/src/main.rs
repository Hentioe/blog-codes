#[repr(packed)]
struct Packed {
    not_aligned_field: i32,
}

fn main() {
    let p = Packed {
        not_aligned_field: 1_82,
    };

    // 这是未定义行为！
    // 它被编译器拒绝。
    //let ptr = &p.not_aligned_field as *const i32;

    // 这是创建指针的旧方式。
    let ptr = std::ptr::addr_of!(p.not_aligned_field);

    // 这是新的方式。
    let ptr = &raw const p.not_aligned_field;

    // 访问指针没有变化。
    // 注意，`val = *ptr` 是未定义行为，因为指针未对齐！
    let val = unsafe { ptr.read_unaligned() };
}
enum Void {}
struct MyStruct {
    field: Void,
}

pub fn unwrap_without_panic<T>(x: Result<T, MyStruct>) -> T {
    let Ok(x) = x; // `Err` 分支不需要出现
    x
}
