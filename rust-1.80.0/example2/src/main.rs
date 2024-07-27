fn main() {
    println!("example: {:?}", size_prefix(1000));
}

pub fn size_prefix(n: u32) -> &'static str {
    const K: u32 = 10u32.pow(3);
    const M: u32 = 10u32.pow(6);
    const G: u32 = 10u32.pow(9);
    match n {
        ..K => "",
        K..M => "k",
        M..G => "M",
        G.. => "G",
    }
}
