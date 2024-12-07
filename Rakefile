require 'rake'

desc "Hook our dotfiles into system-standard positions."
task :install do
  linkables = Dir.glob('*/**{.symlink}') + Dir.glob('*/**/**{.symlink}')

  skip_all = false
  overwrite_all = false
  backup_all = false

  def run command
    puts "Running command: #{command}" if verbose
    `#{command}`
  end

  linkables.each do |linkable|
    overwrite = false
    backup = false

    # Remove folder and .symlink. It supports files inside folders like ".vagrant.d/Vagrantfile"
    file = linkable.split('/')[1..-1].join("/").split('.symlink').last
    target = "#{ENV["HOME"]}/.#{file}"
    
    if File.exist?(target) || File.symlink?(target)
      unless skip_all || overwrite_all || backup_all
        puts "File already exist: #{target}, what do you want to do? [s]kip, [S]kip all, [o]verwrite, [O]verwrite all, [b]ackup, [B]ackup all"
        case STDIN.gets.chomp
        when 'o' then overwrite = true
        when 'b' then backup = true
        when 'O' then overwrite_all = true
        when 'B' then backup_all = true
        when 'S' then skip_all = true
        when 's' then next
        end
      end
      FileUtils.rm_rf(target) if overwrite || overwrite_all
      run("mv \"$HOME/.#{file}\" \"$HOME/.#{file}.backup\"") if backup || backup_all
    end
    run("ln -s \"$PWD/#{linkable}\" \"#{target}\"") unless skip_all
  end
end

task :uninstall do

  linkables = Dir.glob('*/**{.symlink}') + Dir.glob('*/**/**{.symlink}')
  linkables.each do |linkable|

    file = linkable.split('/')[1..-1].join("/").split('.symlink').last
    target = "#{ENV["HOME"]}/.#{file}"

    # Remove all symlinks created during installation
    if File.symlink?(target)
      FileUtils.rm(target)
    end
    
    # Replace any backups made during installation
    if File.exist?("#{ENV["HOME"]}/.#{file}.backup")
      `mv "$HOME/.#{file}.backup" "$HOME/.#{file}"` 
    end

  end
end

task :default => 'install'
