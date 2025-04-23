# B4課題用 ROS 2 Dockerコンテナ環境
ROS 2課題の環境構築に使う．
なお，本課題およびこのDockerコンテナ環境はホストマシンがWindowsであることを想定している．各自，研究室で与えられたWindows PCを使って課題に取り組むとよい．

# 使い方
## リポジトリのクローン
以下のコマンドを使って，このリポジトリをクローンする．
```bash
git clone --recursive https://github.com/RAIT-09/b4_ros2.git
```
## .envファイルの用意
リポジトリに含まれる`.env.example`ファイルを`.env`に改名する．
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
