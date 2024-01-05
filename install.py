import os

def install_todo():
    os.system("git clone https://github.com/oberon-git/todo")
    os.chdir("todo")
    os.system("cargo build --release")
    os.system("bin target/release/todo")
    os.chdir("../")
    os.system("rm -rf todo")

def main():
    install_todo()

if __name__ == "__main__":
    main()
