#!/bin/sh
INSTALL_PATH=$( cd $(dirname $0); pwd )
# 0. check
if [ -f "$HOME/.bashrc" ] || [ -h "$HOME/.bashrc" ]; then
  echo "Please backup your bashrc before setup"
  exit 1
fi
if [ -f "$HOME/.bash_aliases" ]  || [ -h "$HOME/.bash_aliases" ]; then
  echo "Please backup your bash alias script before setup"
  exit 1
fi
if [ -f "$HOME/.bash_aliases" ] || [ -h "$HOME/.bash_helper" ]; then
  echo "Please backup your bash helper script before setup"
  exit 1
fi


echo "Install path is $INSTALL_PATH"
echo "Now, seting up your bash environment..."
echo ""

# 1. Everything is ok, let's link all necessary files
if [ -f "$HOME/.bash_$USER" ] || [ -h "$HOME/.bash_$USER" ]; then
  echo "Your personal shell already existed."
else
  touch $INSTALL_PATH/.bash_$USER
  ln -s $INSTALL_PATH/.bash_$USER $HOME/.bash_$USER
fi
cp $INSTALL_PATH/default.bashrc $INSTALL_PATH/.bashrc
ln -s $INSTALL_PATH/.bashrc $HOME/.bashrc
ln -s $INSTALL_PATH/alias.sh $HOME/.bash_aliases
ln -s $INSTALL_PATH/helper.sh $HOME/.bash_helper

. $HOME/.bashrc

echo "Done. Enjoy it!"
echo ""
