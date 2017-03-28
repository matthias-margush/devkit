FROM alpine:edge
WORKDIR /root
RUN apk add --no-cache emacs git curl zsh
RUN git clone https://github.com/syl20bnr/spacemacs ~/.emacs.d
COPY .spacemacs ./
RUN yes | emacs --batch -l ~/.emacs.d/init.el --eval='(configuration-layer/update-packages)'
RUN emacs --batch -l ~/.emacs.d/init.el
RUN git clone git://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh && \
    cp ~/.oh-my-zsh/templates/zshrc.zsh-template ~/.zshrc
COPY .zshenv ./.zshenv
ENTRYPOINT ["zsh"]
