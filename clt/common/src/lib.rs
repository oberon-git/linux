use std::any;

pub fn print_type<T>(_: &T) {
    println!("{}", any::type_name::<T>());
}
