export PATH=/Users/fgao/homebrew/bin:/usr/local/bin:~/Library/Python/2.7/bin:~/bin:$PATH
alias k='kubectl'
export WORKON_HOME=$HOME/.virtualenvs
export PROJECT_HOME=$HOME/Devel
source /Users/fgao/bin/virtualenvwrapper.sh 

kubectl-restart() {
  kubectl -n $1 get deploy $2 -o json | jq \
    'del(
      .spec.template.spec.containers[0].env[]
      | select(.name == "RESTART_"))
    | .spec.template.spec.containers[0].env += [{name: "RESTART_", value: now|tostring}]' | kubectl -n $1 apply -f -
}
