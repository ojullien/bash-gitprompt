#!/bin/bash
## -----------------------------------------------------------------------------
## Linux Scripts.
## This tool allows you to use update the JanDeDobbeleer/oh-my-posh prompt.
##
## @package ojullien\bash
## @license MIT <https://github.com/ojullien/ohmyposh-tool/blob/master/LICENSE>
## -----------------------------------------------------------------------------
#set -o errexit
set -o nounset
set -o pipefail

## -----------------------------------------------------------------------------
## Usefull functions and variables
## -----------------------------------------------------------------------------

readonly OJU_LOCAL_BIN=$HOME/.local/bin
readonly OJU_OMP_BIN=${OJU_LOCAL_BIN}/oh-my-posh
readonly OJU_OMP_DIR=$HOME/.ohmyposh
readonly OJU_OMP_THEME_DIR=themes
readonly OJU_OMP_THEME_NAME=oju

OmPTool::showHelp() {
    echo "Usage: $(basename "$0") <command>"
    echo -e "\tInstall or update the Oh my Posh binary and themes."
    echo -e "\tCommands list:"
    echo -e "\t\tinstall\tInstall the Oh my Posh binary and themes"
    echo -e "\t\tthemes\tUpdate the Oh my Posh themes"
    echo -e "\t\tupdate\tUpdate the Oh my Posh binary"
    echo -e "\t\tpreview\tPreview the themes"
    return 0
}

OmPTool::createDir() {

    # Parameters
    if (($# != 2)) || [[ -z "$1" ]] || [[ -z "$2" ]]; then
        echo "Usage: OmPTool::createDir <bin dir> <oh my posh theme dir>"
        return 1
    fi

    # Init
    local sBinDir="$1" sOmPDir="$2"

    # Do the job
    mkdir --parents --verbose "${sBinDir}" "${sOmPDir}"

    return $?
}

OmPTool::updateBin() {

    # Parameters
    if (($# != 1)) || [[ -z "$1" ]]; then
        echo "Usage: OmPTool::updateBin <file path>"
        return 1
    fi

    # Init
    local sPath="$1"
    local -i iReturn=1

    # Do the job
    rm -fv "${sPath}"
    wget https://github.com/JanDeDobbeleer/oh-my-posh/releases/latest/download/posh-linux-amd64 -O "${sPath}"
    iReturn=$?
    chmod +x "${sPath}"

    return ${iReturn}
}

OmPTool::updateThemes() {

    # Parameters
    if (($# != 2)) || [[ -z "$1" ]] || [[ -z "$2" ]]; then
        echo "Usage: OmPTool::updateTheme <themes dir> <file name to keep>"
        return 1
    fi

    # Init
    local sThemesDir="$1" sKeepFile="$2"
    local -i iReturn=1

    # Do the job
    find "${sThemesDir}" -type f -not -name "${sKeepFile}.omp.json" -delete
    wget https://github.com/JanDeDobbeleer/oh-my-posh/releases/latest/download/themes.zip -O "${sThemesDir}/themes.zip"
    unzip "${sThemesDir}/themes.zip" -d "${sThemesDir}"
    rm -fv ${sThemesDir}/themes.zip
    find "${sThemesDir}" -type f -name *.json -exec chmod 600 {} \;

    return ${iReturn}
}

## -----------------------------------------------------------------------------
## Help
## -----------------------------------------------------------------------------
(($#<1)) && OmPTool::showHelp && exit 1
[[ -z "$1" ]] && OmPTool::showHelp && exit 1

## -----------------------------------------------------
## Do the job
## -----------------------------------------------------

case "$1" in

    install|i) # Install binary and themes
        OmPTool::createDir "${OJU_LOCAL_BIN}" "${OJU_OMP_DIR}/${OJU_OMP_THEME_DIR}"
        OmPTool::updateBin "${OJU_OMP_BIN}"
        OmPTool::updateThemes "${OJU_OMP_DIR}/${OJU_OMP_THEME_DIR}" "${OJU_OMP_THEME_NAME}"
        ;;

    update|u) # Update binary
        OmPTool::updateBin "${OJU_OMP_BIN}"
        ;;

    themes|t) # Update themes
        OmPTool::updateThemes "${OJU_OMP_DIR}/${OJU_OMP_THEME_DIR}" "${OJU_OMP_THEME_NAME}"
        ;;

    preview|p) # Preview the themes
        for file in "${OJU_OMP_DIR}/${OJU_OMP_THEME_DIR}/*.omp.json"; do echo "$file\n"; oh-my-posh --config $file --shell universal; echo "\n"; done;
        ;;
    *)
        OmPTool::showHelp
        ;;
esac

exit 0
