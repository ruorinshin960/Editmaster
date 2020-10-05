lock '3.12.0'
# config valid only for current version of Capistrano -->
# capistranoのバージョンを記載。固定のバージョンを利用し続け、バージョン変更によるトラブルを防止する

set :application, 'Editmaster'
# Capistranoのログの表示に利用する

set :repo_url,  'git@github.com:mkt-wakabayashi/Editmaster.git'
# どのリポジトリからアプリをpullするかを指定する

set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system', 'public/uploads')
# バージョンが変わっても共通で参照するディレクトリを指定

set :rbenv_type, :user
set :rbenv_ruby, '2.5.1' 

set :ssh_options, auth_methods: ['publickey'],
                  keys: ['~/.ssh/editmaster-second.pem'] 
# どの公開鍵を利用してデプロイするか

set :unicorn_pid, -> { "#{shared_path}/tmp/pids/unicorn.pid" }
# プロセス番号を記載したファイルの場所

set :unicorn_config_path, -> { "#{current_path}/config/unicorn.rb" }
set :keep_releases, 5
# Unicornの設定ファイルの場所

after 'deploy:publishing', 'deploy:restart'
namespace :deploy do
  task :restart do
    invoke 'unicorn:restart'
  end
end
# デプロイ処理が終わった後、Unicornを再起動するための記述