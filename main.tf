
module "mfa_group" {
   source = "./mfa_group"

   list_of_mfa_users = ["<USER-NAME>"]
   account-id = "<ACCOUNT-ID>"
   ip_whitelist = ["<IP1>/32","<IP2>/32"]
}
