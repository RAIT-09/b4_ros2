# B4課題用 ROS 2 Dockerコンテナ環境
ROS 2課題の環境構築に使う．
なお，本課題およびこのDockerコンテナ環境はホストマシンがWindowsであることを想定している．各自，研究室で与えられたWindows PCを使って課題に取り組むとよい．

# 使い方
## リポジトリのクローン
以下のコマンドを使って，このリポジトリを**WSLのUbuntu上に**クローンする．
```bash
git clone --recursive https://github.com/RAIT-09/b4_ros2.git
```
## .envファイルの用意
リポジトリに含まれる`.env.example`ファイルを`.env`としてコピーする．
```bash
cp .env.example .env
```
## Dev Containersの利用
本リポジトリは，Visual Studio Code（以下 VS Code）のDev Containers機能を設定済である．

Dev Containersとは，VS CodeにおいてDockerコンテナを用いた開発環境を容易に構築・共有するための仕組みである．
VS Codeに「Dev Containers」拡張機能をインストールした上で，「コンテナーで再度開く（Reopen in Container）」を選択することで，指定されたDocker環境が自動的に立ち上がり，統一された開発環境が利用可能となる．

なお，以下のようにコマンドライン操作によってコンテナを起動・利用することも可能であるが，基本的にはDev Containers経由での利用を推奨する．
## コンテナの起動
以下のコマンドを**WSLのUbuntu上で**実行して，ROS 2コンテナを起動する．
```bash
docker compose up -d
```
## コンテナ内でコマンドを実行する
以下のコマンドを**WSLのUbuntu上で**実行して，ROS 2コンテナのBashを使用する．
```bash
docker exec -it b4_ros2 bash
```
# GUI表示
このDockerコンテナ環境ではROS 2のGUI表示を行うため，WSLgを使用する設定を行なっている．PowerShellもしくはコマンドプロンプトで以下のコマンドを実行し，WSLgが利用可能であることを確認する．
```powershell
wsl --version
```

コンテナの起動後にRviz2を実行して，GUI表示が機能することを確認するとよい．

```bash
rviz2
```

# ターミナルの多重化
tmuxを導入しているので，それを使用するとよい．
