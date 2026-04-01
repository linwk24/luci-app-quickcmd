# luci-app-quickcmd
<img width="1909" height="831" alt="Screenshot (2)" src="https://github.com/user-attachments/assets/466302a0-300e-4fa8-96ca-8cd65d322601" />
快捷命令管理是一款面向嵌入式OpenWrt 的 WebUI 增强插件，为用户提供可视化、可一键执行的 Shell 命令 / 脚本管理能力，彻底告别繁琐的 SSH 手动输入，让系统运维更高效、更安全。
## 适用场景
- 嵌入式路由 / OpenWrt 设备：一键执行系统状态检测、网络配置、存储管理等命令
- 私有 NAS / 家庭服务器（如 fnOS）：批量文件处理、定时任务管理、系统备份等运维操作
- 嵌入式开发板：快速执行调试命令、脚本自动化，提升开发效率
- 新手用户：无需掌握复杂 Linux 命令，通过可视化界面完成系统运维

## 部署方式
```bash
cd 你存放目录路径/luci-app-quickcmd
chmod +x install.sh
./install.sh
