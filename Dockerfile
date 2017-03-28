FROM alpine:edge
WORKDIR /root
RUN apk add --no-cache emacs git curl zsh openjdk8 bash
RUN git clone https://github.com/syl20bnr/spacemacs ~/.emacs.d
COPY .spacemacs ./
RUN yes | emacs --batch -l ~/.emacs.d/init.el --eval='(configuration-layer/update-packages)'
RUN emacs --batch -l ~/.emacs.d/init.el
RUN git clone git://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh && \
    cp ~/.oh-my-zsh/templates/zshrc.zsh-template ~/.zshrc
RUN curl -o /usr/bin/lein https://raw.githubusercontent.com/technomancy/leiningen/stable/bin/lein && \
    chmod 755 /usr/bin/lein && lein
COPY .zshenv ./.zshenv
ENTRYPOINT ["zsh"]
