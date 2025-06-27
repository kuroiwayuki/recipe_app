# Pin npm packages by running ./bin/importmap

pin "application"
pin "stimulus-rails-nested-form" # @4.1.0
pin "@hotwired/stimulus", to: "@hotwired--stimulus.js" # @3.2.2
pin_all_from "app/javascript/controllers", under: "controllers"