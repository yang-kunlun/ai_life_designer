import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('个人中心'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              // TODO: 打开设置页面
              Get.snackbar(
                '提示',
                '设置功能即将推出',
                snackPosition: SnackPosition.BOTTOM,
              );
            },
          ),
        ],
      ),
      body: ListView(
        children: [
          // 用户信息卡片
          Card(
            margin: const EdgeInsets.all(8),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    child: const Icon(
                      Icons.person,
                      size: 32,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(width: 16),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '未登录',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          '点击登录账号',
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Icon(Icons.chevron_right),
                ],
              ),
            ),
          ),

          // 功能列表
          const SizedBox(height: 16),
          ListTile(
            leading: const Icon(Icons.notifications),
            title: const Text('消息通知'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              Get.snackbar(
                '提示',
                '消息通知功能即将推出',
                snackPosition: SnackPosition.BOTTOM,
              );
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.color_lens),
            title: const Text('主题设置'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              Get.snackbar(
                '提示',
                '主题设置功能即将推出',
                snackPosition: SnackPosition.BOTTOM,
              );
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.language),
            title: const Text('语言设置'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              Get.snackbar(
                '提示',
                '语言设置功能即将推出',
                snackPosition: SnackPosition.BOTTOM,
              );
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.help),
            title: const Text('帮助与反馈'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              Get.snackbar(
                '提示',
                '帮助与反馈功能即将推出',
                snackPosition: SnackPosition.BOTTOM,
              );
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.info),
            title: const Text('关于'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              showAboutDialog(
                context: context,
                applicationName: 'AI Life Designer',
                applicationVersion: '1.0.0',
                applicationIcon: const FlutterLogo(size: 32),
                children: const [
                  Text('AI Life Designer是一款基于AI的智能日程助手，'
                      '通过自然语言交互帮助用户优化生活方式、管理日程安排的移动应用。'),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
