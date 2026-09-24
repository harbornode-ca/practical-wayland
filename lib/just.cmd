1,gum style "Installing Rust and Cargo"
2,gum style "Checking for existing installation of Rust"
3,if [ -d "$HOME/.cargo" ]; then style=msg; gum style "Rust is already installed"; sleep 1.5; rustStatus=1; else style=msg; gum style "Rust not installed"; sleep 1.5; rustStatus=0; fi
4,if [ $rustStatus -eq 0 ]; then scripts/stubs/2609fd1bba.sh; fi
5,if [ $rustStatus -eq 1 ]; then scripts/stubs/2609ebcd21.sh; fi
6,gum style "Checking for existing installation of Just"
7,if [ -f $HOME/.cargo /bin/just ]; then gum sytle "Just already installed for user $whoami"; sleep 1.5; export justStatus=1; else gum style "Rust not installed for user $whoami"; sleep 1.5; export justStatus=0; fi;
8,if [ $justStatus -eq 0 ]; then gum spin --title="Installing Just for user $whoami" $stubDir/2609b4dcf6.sh; fi
9,if [ $justStatus -eq 1 ]; then gum spin --title="Updating Just for user $whoami" $stubDir/2609b4dcf6.sh; fi
10,gum style "Checking for Just installation in /usr/sbin"; sleep 1.5;
11,if [ -f /usr/bin/just ]; then style=msg; gum style "Just is already installed in /usr/sbin"; rootJust=1; else gum style "Just not install in /usr/sbin"; sleep 1.5; rootJust=0; fi
12,if [ $rootJust -eq 0 ]; then gum style "Copying just from $HOME/.cargo/bin/ to /usr/bin"; sleep 1.5; sudo cp -f $HOME/.cargo/bin/just /usr/sbin; fi
13,if [ $rootJust -eq 1 ]; then gum style "Confirming /usr/sbin/just is up to date"; sleep 1.5; sudo cp -f $HOME/.cargo/bin/just /usr/sbin; fi
14,gum style "Installation of Rust and Just is complete"; sleep 1.5;