# .bashrc
export HISTSIZE=100000
export HISTFILESIZE=100000
shopt -s histappend
PROMPT_COMMAND="history -a;$PROMPT_COMMAND"


if [ "dumb" != $TERM ]; then

  source ~/git/dotfiles-1/git_bash
  # PS1
  ##################################################
  get_CMSSW_version (){
      if [ $CMSSW_BASE ] ; then
          local OUTPUT=$(basename $CMSSW_BASE)
          OUTPUT=$(echo $OUTPUT | sed "s/CMSSW_//g")
          echo " $OUTPUT"
      else
          echo ""
      fi
  }

  upload(){
      for i in ${@:1}
      do
	  scp $i ursu@velicanu.com:/usr/share/nginx/html/
	  echo velicanu.com/$i
      done
  }

  open(){
      if [[ $PWD == *"tesseract"* ]]
      then
	  echo using remote
	  thiswd=$PWD
	  cd ~/
	  gnome-open "$thiswd"/$1
	  cd -
      else
	  echo using local
	  gnome-open $1
      fi
  }
  PS1='\[\033[01;32m\]\h\[\033[00;35m\]$(get_CMSSW_version) \[\033[00;32m\]$(get_git_info)\[\033[01;34m\] \W \$\[\033[00m\] '

  # eval `/home/ursu/cmspapers/notes/tdr runtime -sh`

  # alias python="python3"
  alias em="emacs -nw"
  alias alert="notify-send"
  alias hgrep="cat ~/.bash_history | sed 's/^ *[0-9]* *//' | cat ~/.bash_history - | sort | uniq | grep "
  alias rgrep="cat ~/.root_history | sed 's/^ *[0-9]* *//' | cat ~/.root_history - | sort | uniq | grep "
  alias htdr="~/cmspaper/notes/tdr --style=an b AN-15-019"

  # enable color support of ls and also add handy aliases
  if [ -x /usr/bin/dircolors ]; then
      test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
      alias ls='ls --color=auto'
      #alias dir='dir --color=auto'
      #alias vdir='vdir --color=auto'

      alias grep='grep --color=auto'
      alias fgrep='fgrep --color=auto'
      alias egrep='egrep --color=auto'
  fi

  
  function fkill() {
      ps | grep ffgamma.exe | awk '{print "kill "$1}' | bash
  }
  function gkill() {
      ps -aux | grep gdb | awk '{print "kill -9 "$2}' | bash
  }

  # Source global definitions
  if [ -f /etc/bashrc ]; then
    . /etc/bashrc
  fi





  
  # if [ "hidsk0001.cmsaf.mit.edu" == `hostname` ]
  # then
  #   eval `~/scratch1/cmspaper01/notes/tdr runtime -sh`
  # fi
fi

PATH="/home/ursu/perl5/bin${PATH:+:${PATH}}"; export PATH;
PERL5LIB="/home/ursu/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"; export PERL5LIB;
PERL_LOCAL_LIB_ROOT="/home/ursu/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"; export PERL_LOCAL_LIB_ROOT;
PERL_MB_OPT="--install_base \"/home/ursu/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=/home/ursu/perl5"; export PERL_MM_OPT;
