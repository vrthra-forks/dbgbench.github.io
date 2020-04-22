find_bugs=c8491c11 dbcb10e9 93623752 07b941b1
grep_bugs=3c3bdace 9c45c193 54d55bba

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
