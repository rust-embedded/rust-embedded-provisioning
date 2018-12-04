rust-embedded-provisioning
==========================

> Terraform provisioning for Rust Embedded infrastructure in AWS

This repository provides the [Terraform](https://www.terraform.io/)
configuration for [Amazon Web Services](https://aws.amazon.com) infrastructure
used by the [Rust Embedded](https://github.com/rust-embedded) organization.

## DNS

DNS records are configured in [route53.tf](route53.tf) and manually applied using terraform.

## Mail

`teams.rust-embedded.org` mailing lists are managed using a dedicated mailgun account that @ryankurte and @nastevens have access to.
The [teams.rust-embedded.org.json](teams.rust-embedded.org.json) file contains a list of team email addresses that can be synchronized to a mailgun instance using [ryankurte/mg-cli](https://github.com/ryankurte/mg-cli), synchronisation and user mangement are currently manual.

