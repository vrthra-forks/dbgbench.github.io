find_bugs=c8491c11 dbcb10e9 93623752 07b941b1
grep_bugs=3c3bdace 9c45c193 54d55bba

all:
	@echo general targets: init rm
	@echo find specific targets: init-find rm-find
	@echo grep specific targets: init-grep rm-grep

rmfind-%:
	 sudo docker stop $* || echo done
	 sudo docker rm $* || echo done

initfind-%:
	sudo ./run.sh find $*


rmgrep-%:
	 sudo docker stop $* || echo done
	 sudo docker rm $* || echo done

initgrep-%:
	sudo ./run.sh grep $*


init-find: $(addprefix initfind-,$(find_bugs))
	@echo done

rm-find: $(addprefix rmfind-,$(find_bugs))
	@echo done

init-grep: $(addprefix initgrep-,$(grep_bugs))
	@echo done

rm-grep: $(addprefix rmgrep-,$(grep_bugs))
	@echo done

init: init-find init-grep
	@echo init done

rm: rm-find rm-grep
	@ecno clobber done
