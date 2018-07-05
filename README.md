# My .Dots

## Tips

To remove `work-profile` and `aws-credentials` from being tracked on git. run the following:

```shell
git update-index --assume-unchanged ./files/work-profile ./files/aws-credentials
```


## GPG Signing

### Creating a new key
 
Requirements:
  - GPG (`brew install gpg`)
  - Git >= v2.0 (`brew install git && brew link git`)
  - [Keybase.app](https://keybase.io/) (`brew cask install keybase`)

```sh
$ keybase pgp gen --multi
# Enter your real name, which will be publicly visible in your new key: Example Exampleton
# Enter a public email address for your key: ex@example.com
# Enter another email address (or <enter> when done):
# Push an encrypted copy of your new secret key to the Keybase.io server? [Y/n] Y
# ▶ INFO PGP User ID: Example Exampleton <ex@example.com> [primary]
# ▶ INFO Generating primary key (4096 bits)
# ▶ INFO Generating encryption subkey (4096 bits)
# ▶ INFO Generated new PGP key:
# ▶ INFO   user: Example Exampleton <ex@example.com>
# ▶ INFO   4096-bit RSA key, ID CC66B456E865BBEE, created 2016-04-06
# ▶ INFO Exported new key to the local GPG keychain
```

#### Git Setup

```sh
$ gpg --list-secret-keys --keyid-format LONG
# /Users/$USERNAME/.gnupg/secring.gpg
# ----------------------------------
# sec   4096R/865BBEE 2018-06-05 [expires: 2032-06-05]
# uid                  Example Exampleton <ex@example.com>

$ git config --global user.signingkey 865BBEE
$ git config --global commit.gpgsign true
```

#### Saving Generated Key to Github
```
$ keybase pgp export -q CB86A866E870EE00 | pbcopy && open https://github.com/settings/keys
```

### Import Keybase GPG keys

```sh
$ keybase pgp export
# ▶ WARNING Found several matches:
# user: Example Exampleton <ex@example.com>
# 4096-bit RSA key, ID 865BBEE, created 2018-06-05

# user: Other Key <other@email.com>
# 4096-bit RSA key, ID 3F4GD5, created 2018-04-23

$ keybase pgp export -q 865BBEE | gpg --import
$ keybase pgp export -q 865BBEE --secret | gpg --allow-secret-key-import --import
```
