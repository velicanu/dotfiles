# .bashrc
export HISTSIZE=100000
export HISTFILESIZE=100000
shopt -s histappend
PROMPT_COMMAND="history -a;$PROMPT_COMMAND"

if [ "dumb" != $TERM ]; then

  
  if [ "hisrv0001.cmsaf.mit.edu" == `hostname` ]
  then
    ssh -X hidsk0001
  fi
  # export CVSROOT=:gserver:cmscvs.cern.ch:/cvs_server/repositories/CMSSW
  if [ "hissh0002.cmsaf.mit.edu" == `hostname` ]
  then
    ssh -X hidsk0001
  fi
  
  stty intr \^k

  # if [ ${SHLVL} -eq 1 ]; then
      # ((SHLVL+=1)); export SHLVL
      # exec screen -R -e "^Ee" ${SHELL} -l
  # fi

  alias hgrep="cat ~/.bash_history | sed 's/^ *[0-9]* *//' | cat ~/.bash_history - | sort | uniq | grep "
  alias rgrep="cat ~/.root_history | sed 's/^ *[0-9]* *//' | cat ~/.root_history - | sort | uniq | grep "
  alias srgrep="cat ~/scratch1/.root_history | sed 's/^ *[0-9]* *//' | cat ~/scratch1/.root_history - | sort | uniq | grep "
  alias cgrep="cd /condor/execute/ ; grep dav2105 */*"
  alias ctail="tail _condor_stdout"
  alias wei="pushd . ; cd /pnfs/cmsaf.mit.edu/t2bat/cms/store/user/davidlw/MinimumBias"
  alias sc="pushd . ; cd /net/hidsk0001/d00/scratch/dav2105"
  alias corr="pushd . ; cd ~/run/CMSSW_3_9_7/src/WeisQCDAna/DiHadronCorrelationAnalyzer"
  alias cq="condor_q dav2105"
  alias cs="condor_status | tail"
  alias ki="kinit -5 velicanu@CERN.CH"
  # alias htdr="tdr --style=paper b HIN-11-006"
  # alias htdr="tdr --style=pas b AN-12-030"
  alias htdr="tdr --style=pas b AN-12-352"
  # alias atdr="tdr --style=note b AN-11-118"
  alias logs="pushd ~/scratch1/logs/"
  alias hbat="ssh -X hibat0004"
  alias crab1="source /osg/grid/setup.sh; grid-proxy-init"
  alias crab2="source /osg/app/crab/crab.sh; source /osg/app/glite/etc/profile.d/grid_env.sh; source /osg/app/cmssoft/cms/cmsset_default.sh"
  # alias ssh="ssh -X"
  alias ftail="tail -f out.log"

  alias ut="ls -tr ~/unmerged/*.root | tail"


  # count()
  # {
    # ls -l $1 | wc -l
  # }

   

  # export SCRAM_ARCH=slc5_amd64_gcc434
  source /osg/app/cmssoft/cms/cmsset_default.sh
  source /net/hisrv0001/home/dav2105/useful_macros/super_hadd.sh
  source /net/hisrv0001/home/dav2105/useful_macros/groupmerge.sh
  # User specific aliases and functions
  # source /opt/bin/sh/setroot.sh 5-26-00
  # source /opt/bin/sh/setroot.sh 5-18-00
  alias root='root -l'
  # source setosgapp_sl5
  #kinit -5 -4 velicanu@CERN.CH
  # alias c58='cd ~/run/CMSSW_3_5_8_patch3/src ; cmsenv'
  # alias c61='cd ~/run/CMSSW_3_6_1/src ; cmsenv'
  # alias c62='cd ~/run/CMSSW_3_6_2_patch3/src ; cmsenv'
  # alias c70='cd ~/run/CMSSW_3_7_0_patch4/src ; cmsenv'
  # alias c92='cd ~/run/CMSSW_3_9_2_patch5/src ; cmsenv'
  # alias c97='cd /net/hidsk0001/d00/scratch/dav2105/home_overflow/CMSSW_3_9_7/src ; cmsenv'
  # alias c99='cd ~/run/CMSSW_3_9_9_patch1/src ; cmsenv'
  # alias c42='export SCRAM_ARCH=slc5_amd64_gcc434 ; cd ~/run/CMSSW_4_2_9_HLT/src ; cmsenv'
  # alias c44='export SCRAM_ARCH=slc5_amd64_gcc434 ; cd ~/run/CMSSW_4_4_0_pre8/src/ ; cmsenv'
  alias c440='export SCRAM_ARCH=slc5_amd64_gcc434 ; cd ~/hihlttest/CMSSW_4_4_0/src/ ; cmsenv'
  alias c441='export SCRAM_ARCH=slc5_amd64_gcc434 ; cd ~/run/CMSSW_4_4_1/src/ ; cmsenv'
  alias c4411='export SCRAM_ARCH=slc5_amd64_gcc434 ; cd ~/hihlttest/CMSSW_4_4_1/src/ ; cmsenv'
  alias c442='export SCRAM_ARCH=slc5_amd64_gcc434 ; cd ~/run/CMSSW_4_4_2/src/ ; cmsenv'
  alias c444='export SCRAM_ARCH=slc5_amd64_gcc434 ; cd ~/run/CMSSW_4_4_4/src/ ; cmsenv'
  alias c445='export SCRAM_ARCH=slc5_amd64_gcc434 ; cd ~/run/CMSSW_4_4_4/src/ ; cmsenv'
  alias c423='export SCRAM_ARCH=slc5_amd64_gcc434 ; cd ~/run/CMSSW_4_2_3_SLHC2/src/ ; cmsenv'
  alias c525='export SCRAM_ARCH=slc5_amd64_gcc462 ; cd ~/run/CMSSW_5_2_5_patch1/src/ ; cmsenv'
  alias lx="ssh -X -Y velicanu@lxplus.cern.ch"
  alias sv="ssh -X -Y velicanu@svmithi01.cern.ch"
  alias cg="ssh -X -Y dav2105@portal.cmsaf.mit.edu"

  # Source global definitions
  if [ -f /etc/bashrc ]; then
    . /etc/bashrc
  fi





  
  if [ "hidsk0001.cmsaf.mit.edu" == `hostname` ]
  then
    eval `~/scratch1/cmspaper01/notes/tdr runtime -sh`
  fi
fi
