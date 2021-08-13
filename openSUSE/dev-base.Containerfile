ARG VARIANT="15.3"
FROM opensuse/leap:${VARIANT}

RUN zypper --non-interactive ref \
        && zypper --non-interactive in sudo nano \
        && zypper --non-interactive clean -a
