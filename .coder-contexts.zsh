declare -A CODER_CONTEXTS
CODER_CONTEXTS[prod]="https://coder.mcrn.cc"
CODER_CONTEXTS[dev]="https://dev-coder.mcrn.cc"
CODER_CONTEXTS[enc]="https://enc-coder.mcrn.cc"
CODER_CONTEXTS[coder-main]="https://coder-main.mcrn.cc"
CODER_CONTEXTS[mac]="http://coder.rshl.cc"
CODER_CONTEXTS[devdev]="http://dev.coder.com"

CODER_CONTEXTS_DIR="${HOME}/.config/coder-contexts"

coder-use() {
    local context=$1
    if [[ -z "${CODER_CONTEXTS[$context]}" ]]; then
        echo "Unknown context: $context"
        echo "Available: ${(k)CODER_CONTEXTS}"
        return 1
    fi
    export CODER_CONFIG_DIR="${CODER_CONTEXTS_DIR}/${context}"
    export CODER_CURRENT_CONTEXT="$context"
    unset CODER_URL
    unset CODER_SESSION_TOKEN
    echo "Switched to: $context (${CODER_CONTEXTS[$context]})"
}

coder-login() {
    local context="${1:-$CODER_CURRENT_CONTEXT}"
    if [[ -z "$context" ]]; then
        echo "No context specified and no current context set."
        echo "Usage: coder-login [context]"
        echo "Available: ${(k)CODER_CONTEXTS}"
        return 1
    fi
    if [[ -z "${CODER_CONTEXTS[$context]}" ]]; then
        echo "Unknown context: $context"
        echo "Available: ${(k)CODER_CONTEXTS}"
        return 1
    fi

    CODER_CONFIG_DIR="${CODER_CONTEXTS_DIR}/${context}" \
    CODER_URL="" \
    CODER_SESSION_TOKEN="" \
        coder login "${CODER_CONTEXTS[$context]}"

    if [[ "$context" == "$CODER_CURRENT_CONTEXT" ]]; then
        export CODER_CONFIG_DIR="${CODER_CONTEXTS_DIR}/${context}"
    fi
}

coder-logout() {
    local context="${1:-$CODER_CURRENT_CONTEXT}"
    if [[ -z "$context" ]]; then
        echo "No context specified and no current context set."
        echo "Usage: coder-logout [context]"
        return 1
    fi
    if [[ -z "${CODER_CONTEXTS[$context]}" ]]; then
        echo "Unknown context: $context"
        echo "Available: ${(k)CODER_CONTEXTS}"
        return 1
    fi

    echo "Logging out of context: $context (${CODER_CONTEXTS[$context]})"
    CODER_CONFIG_DIR="${CODER_CONTEXTS_DIR}/${context}" \
    CODER_URL="" \
    CODER_SESSION_TOKEN="" \
        coder logout

    if [[ "$context" == "$CODER_CURRENT_CONTEXT" ]]; then
        unset CODER_CONFIG_DIR
        unset CODER_URL
        unset CODER_SESSION_TOKEN
        unset CODER_CURRENT_CONTEXT
    fi
}

coder-contexts() {
    echo "Available contexts:"
    for context in ${(k)CODER_CONTEXTS}; do
        if [[ "$CODER_CURRENT_CONTEXT" == "$context" ]]; then
            echo "  * $context (${CODER_CONTEXTS[$context]})"
        else
            echo "    $context (${CODER_CONTEXTS[$context]})"
        fi
    done
}

coder-current() {
    if [[ -n "$CODER_CURRENT_CONTEXT" ]]; then
        echo "Current context: $CODER_CURRENT_CONTEXT"
        echo "URL: ${CODER_CONTEXTS[$CODER_CURRENT_CONTEXT]}"
        echo "Config: $CODER_CONFIG_DIR"
    else
        echo "No context set. Use 'coder-use <context>' to set one."
    fi
}
