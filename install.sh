#!/bin/bash
#!/bin/bash

os_name=$(uname)

macos_link="https://example.com/retdec-macos.tar.gz"
linux_link="https://example.com/retdec-linux.tar.gz"

# 下载对应版本的 retdec
if [ "$os_name" == "Darwin" ]; then
    echo "Oh, I see, so you are using MAC OS."
    echo "Downloading MacOS retdec ..."
    curl -L -o retdec-macos.tar.gz "$macos_link"
    echo "Download completed, now decompressing ..."
    tar -xzvf retdec-macos.tar.gz
elif [ "$os_name" == "Linux" ]; then
    echo "Oh, I see, so you are using Linux."
    echo "Downloading Linux retdec ..."
    wget -O retdec-linux.tar.gz "$linux_link"
    echo "Download completed, now decompressing ..."
    tar -xzvf retdec-linux.tar.gz
else
    echo "I don't know what OS you are using, please install retdec manually from https://github.com/avast/retdec"
fi

echo "Adding bin/ from retdec to PATH ..."
retdec_bin_path="$(pwd)/${retdec_folder}/bin"

if [ "$os_name" == "Darwin" ]; then
    echo "export PATH=\"$retdec_bin_path:\$PATH\"" | sudo tee -a /etc/paths
elif [ "$os_name" == "Linux" ]; then
    echo "export PATH=\"$retdec_bin_path:\$PATH\"" | sudo tee -a /etc/profile
fi

python_path=$(which python3)
echo "#!$python_path" > temp_file.txt
cat Ret2GPT.py >> temp_file.txt
mv temp_file.txt Ret2GPT.py


python3 -m pip install -r requirements.txt
sudo ln -s "$(pwd)/Ret2GPT.py" /usr/local/bin/ret2gpt
sudo chmod +x /usr/local/bin/ret2gpt
echo -e "\033[31minstallation finished, PLEASE RESTART YOUR TERMINAL\033[0m"