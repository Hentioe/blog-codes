fn main() {
    println!("Hello, world!");
}
//@ edition: 2021
fn f(x: &()) -> impl Sized { x }
