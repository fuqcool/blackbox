Inspired by John Resig, this tool encrypts almost everything that can be put into text, such as password, love letter, diary, etc.

## Usage

### Edit file

```
./blackbox FILE-YOU-WANNA-ENCRYPT
```

Edit and save with vim. The file content will be encrypted after you quit the editor.

### Change password

```
./blackbox FILE-YOU-WANNA-ENCRYPT -p
```

## Example

Try `./blackbox sample.txt` with password `123`.

## Dependencies
- bash
- openssl
- vim

## License
MIT License
