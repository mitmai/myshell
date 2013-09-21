#!/bin/bash
INSTALL_PATH=$( cd $(dirname $0); pwd )
# 0. check
if [ ! -f "/bin/bash" ];then
  echo "Unable to find bash (default: /bin/bash) in your system"
  exit 1
fi

if [ -f "$HOME/.bashrc" ] || [ -h "$HOME/.bashrc" ]; then
  echo "Please backup your bashrc before setup"
  exit 1
fi

if [ -d "$HOME/.bash" ] || [ -h "$HOME/.bash" ]; then
  rm $HOME/.bash
  exit 1
fi



echo "Install path is $INSTALL_PATH"
echo "Now, seting up your bash environment..."
echo ""

# 1. Everything is ok, let's link all necessary files
if [ ! -f "$INSTALL_PATH/mybashrc" ]; then
  touch $INSTALL_PATH/mybashrc
fi
if [ ! -h "$HOME/.bash_$USER" ]; then
  ln -s $INSTALL_PATH/mybashrc $HOME/.bash_$USER
fi

ln -s $INSTALL_PATH $HOME/.bash
ln -s $INSTALL_PATH/default.bashrc $HOME/.bashrc

cp $INSTALL_PATH/tmux.conf $INSTALL_PATH/.tmux.conf
ln -s $INSTALL_PATH/.tmux.conf $HOME/.tmux.conf

/bin/bash $HOME/.bashrc

echo "Done. Enjoy it!"
echo ""
