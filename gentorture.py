
symbols = []

symtemplate = "sym%(version)s%(space)s%(visibility)s"

template = """\
void sym%(version)s%(space)s%(visibility)s() __attribute__((visibility("%(visibility)s")));
void sym%(version)s%(space)s%(visibility)s() {}
"""

for visibility in "default", "hidden", "protected", "internal":
    for space in "nospace", "SPACE":
        for version in "nover", "longver", "shortver":
            print template % globals()
