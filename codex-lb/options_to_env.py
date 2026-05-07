#!/usr/bin/env python3
import json
import os
import shlex
import sys

OPTIONS_FILE = "/data/options.json"
KEY_FILE = "/data/encryption_key.txt"

HARDCODED_IN_RUN_SH = {"port", "host", "oauth_callback_port"}


def main() -> None:
    try:
        with open(OPTIONS_FILE) as fh:
            opts = json.load(fh)
    except Exception as exc:
        print(f"error: could not read {OPTIONS_FILE}: {exc}", file=sys.stderr)
        sys.exit(1)

    for key, value in opts.items():
        if key in HARDCODED_IN_RUN_SH or value is None:
            continue

        if key == "encryption_key":
            if value:
                try:
                    with open(KEY_FILE, "w") as fh:
                        fh.write(value)
                    os.chmod(KEY_FILE, 0o600)
                    print(f"export CODEX_LB_ENCRYPTION_KEY_FILE={shlex.quote(KEY_FILE)}")
                except Exception as exc:
                    print(f"error: could not write key file: {exc}", file=sys.stderr)
                    sys.exit(1)
            continue

        env_name = f"CODEX_LB_{key.upper()}"
        env_value = ("true" if value else "false") if isinstance(value, bool) else str(value)
        print(f"export {env_name}={shlex.quote(env_value)}")


if __name__ == "__main__":
    main()
