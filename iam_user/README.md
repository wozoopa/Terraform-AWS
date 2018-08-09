iam_user
===
IAM User module.

This code is using local-exec to create access_key instead of terraform resource aws_iam_access_key in favor of NOT storing secret_key in state file.

Input Variables
---------------
- `username` - The user's name
- `enable_access_key` - Create access_key for user. Valid entries are `true` or `false`.

NOTE
-------
- If you create user with access_key enabled then deleting them will fail
- You must delete access_keys first & login page
```
$ aws iam list-access-keys --user-name <user-name>
$ aws iam delete-access-key --user-name <user-name> --access-key-id <key-id>
```
then run terraform to delete users.


Usage
-----

1.) Add a module resource to your template, e.g. `main.tf`. Below example shows 4 different scenarios. Default values are set to `false`.
```
module "user1" {
  source                          = "git::https://github.com/wozoopa/aws//iam_user"
  # true  = 1
  # false = 0

  username          = "dev1"
  no_key_no_console = "true"
}

module "user2" {
  source                          = "git::https://github.com/wozoopa/aws//iam_user"

  username                     = "dev2"
  enable_access_key_no_console = "true"
}

module "user3" {
  source                          = "git::https://github.com/wozoopa/aws//iam_user"

  username              = "dev3"
  enable_console_no_key = "true"
}

module "user4" {
  source                          = "git::https://github.com/wozoopa/aws//iam_user"

  username                  = "dev4"
  enable_console_enable_key = "true"
}
```
