Atomic AWS Root Account
=======================

Root AWS account setup.

Currently, this repository sets up:
  - billing policies
  - access control
    - users including login profile and access keys
    - groups and group membership
    - assumable roles for groups

Usage
-----

### Unlocking secrets

Most tasks require access to secrets stored within the repository. To unlock
the secrets, make sure your GPG key has been given access and execute:

```shell script
go secrets:unlock
```

To check if secrets are successfully unlocked, execute:

```shell script
go secrets:check
```

### Provisioning the state storage bucket

To provision the state storage bucket:

```
aws-vault exec <root-profile> -- go "bootstrap:provision[<deployment_type>,<deployment_label>]"
```

### Provisioning policies

To provision policies (for billing management etc.):

```
aws-vault exec <root-profile> -- go "policies:provision[<deployment_type>,<deployment_label>]"
```

### Provisioning access control

To provision access control (users, groups etc.):

```
aws-vault exec <root-profile> -- go "access_control:provision[<deployment_type>,<deployment_label>]"
```

### Adding a new user

To add a new user, add that user's public GPG key (non-armored) to the 
`config/gpg` directory, update the user configuration in 
`config/deployments/ibe-root-default.yaml` and then re-provision the access 
control.

After provisioning, the users encrypted credentials will be output and can be
shared with that user for them to continue setup. The user will be required to
change their password and set up MFA before they can do anything else.

### Adding a new group

To add a group, update the group configuration in 
`config/deployments/ibe-root-default.yaml` with the details of the new group
and then re-provision the access control.

### Changing group association

To add a user to a group, or modify existing associations, update the group
configuration in `config/deployments/ibe-root-default.yaml` and then 
re-provision the access control.

Technologies Used
-----------------

The repository makes use of:

### Languages and Scripting

* [Ruby 2.7](https://ruby-doc.org/core-2.7.2/): Used for build and scripting

### Building and Packaging

* [Rake](http://docs.seattlerb.org/rake/): Simple build tool
* [RubyGems](https://rubygems.org): Packaging tool and standard for Ruby
* [Bundler](http://bundler.io): Dependency manager and isolator for Ruby

### Environment Automation

* [InfraBlocks](https://github.com/infrablocks): Modular and composable 
  libraries for build and infrastructure.

Development Machine Requirements
--------------------------------
  
In order for the build to run correctly, a few tools will need to be installed 
on your development machine:
 
 * Ruby (2.7)
 * Bundler
 * git
 * git-crypt
 * gnupg
 * direnv

### Mac OS X Setup

Installing the required tools is best managed by [homebrew](http://brew.sh) and
[homebrew-cask](http://caskroom.io).

To install homebrew:

```
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
```

Then, to install the required tools:

```
# ruby
brew install rbenv
brew install ruby-build
echo 'eval "$(rbenv init - bash)"' >> ~/.bash_profile
echo 'eval "$(rbenv init - zsh)"' >> ~/.zshrc
eval "$(rbenv init -)"
rbenv install 2.7.2
rbenv rehash
rbenv local 2.7.2
gem install bundler

# git, git-crypt, gnupg
brew install git
brew install git-crypt
brew install gnupg

# direnv
brew install direnv
echo "$(direnv hook bash)" >> ~/.bash_profile
echo "$(direnv hook zsh)" >> ~/.zshrc
eval "$(direnv hook $SHELL)"

direnv allow <repository-directory>
```
