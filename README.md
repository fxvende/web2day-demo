# Démo Web2Day 2017

Déploiement d'un Apache avec Puppet sur deux OS cibles : Ubuntu 16.04 et CentOS 7.

## Pré-requis à installer

- [Ruby 2.3.0](https://rvm.io/)
- [VirtualBox 5.1.22](https://www.virtualbox.org/)
- [Vagrant 1.9.5](https://www.vagrantup.com/)
- [Bundler](http://bundler.io/)

## Préparation des VMs

- Récupérer les GEMs Ruby : `bundle install`
- Initialiser les deux VMs (Ubuntu et RedHat) : `bash prepare_vms.sh`

## Commandes disponibles (entre autre)

- Vérification syntaxe Puppet avec [Puppet Lint](http://puppet-lint.com/) : `rake lint`
- Vérification syntaxe Ruby avec [Rubocop](https://github.com/bbatsov/rubocop/) : `rake rubocop`
- Lancement Tests Unitaire avec [Rspec Puppet](http://rspec-puppet.com/) : `rake spec_standalone`
- Lancement Tests Intégration avec [Kitchen](http://kitchen.ci/) et [ServerSpec](http://serverspec.org/) : `kitchen verify`

## URLs d'affichage de la page déployée sur Apache

Possible uniquement après un `kitchen converge` ou un `kitchen verify` 

- Pour Ubuntu : http://localhost:8080/web2day.html 
- Pour CentOS : http://localhost:8081/web2day.html
