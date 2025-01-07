import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../models/chat_message.dart';

class AIChatPage extends StatefulWidget {
  const AIChatPage({super.key});

  @override
  State<AIChatPage> createState() => _AIChatPageState();
}

class _AIChatPageState extends State<AIChatPage> {
  final TextEditingController _textController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final List<ChatMessage> _messages = [];
  bool _isTyping = false;

  @override
  void dispose() {
    _textController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _handleSubmitted(String text) {
    if (text.trim().isEmpty) return;

    _textController.clear();
    setState(() {
      _messages.add(
        ChatMessage(
          id: DateTime.now().toString(),
          content: text,
          type: MessageType.text,
          role: MessageRole.user,
          timestamp: DateTime.now(),
        ),
      );
      _isTyping = true;
    });

    // 滚动到底部
    Future.delayed(const Duration(milliseconds: 100), () {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });

    // TODO: 调用AI服务处理消息
    // 模拟AI回复
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        _messages.add(
          ChatMessage(
            id: DateTime.now().toString(),
            content: '我是AI助手，我会帮助你管理日程和优化生活方式。',
            type: MessageType.text,
            role: MessageRole.assistant,
            timestamp: DateTime.now(),
          ),
        );
        _isTyping = false;
      });

      // 滚动到底部
      Future.delayed(const Duration(milliseconds: 100), () {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      });
    });
  }

  Widget _buildMessage(ChatMessage message) {
    final isUser = message.role == MessageRole.user;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Row(
        mainAxisAlignment:
            isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          if (!isUser) ...[
            CircleAvatar(
              backgroundColor: Theme.of(context).colorScheme.primary,
              child: const Icon(
                Icons.assistant,
                color: Colors.white,
              ),
            ),
            const SizedBox(width: 8),
          ],
          Flexible(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                color: isUser
                    ? Theme.of(context).colorScheme.primary
                    : Theme.of(context).colorScheme.surfaceVariant,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                message.content,
                style: TextStyle(
                  color: isUser ? Colors.white : null,
                ),
              ),
            ),
          ),
          if (isUser) const SizedBox(width: 8),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AI助手'),
        actions: [
          IconButton(
            icon: const Icon(Icons.help_outline),
            onPressed: () {
              // TODO: 显示帮助信息
              Get.snackbar(
                '提示',
                '您可以通过自然语言与AI助手交谈，创建和管理日程',
                snackPosition: SnackPosition.BOTTOM,
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.all(8.0),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                return _buildMessage(_messages[index]);
              },
            ),
          ),
          if (_isTyping)
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CircleAvatar(
                    child: Icon(Icons.assistant),
                  ),
                  SizedBox(width: 8),
                  Text('AI正在输入...'),
                ],
              ),
            ),
          const Divider(height: 1),
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
            ),
            child: Row(
              children: [
                const SizedBox(width: 16),
                Expanded(
                  child: TextField(
                    controller: _textController,
                    decoration: const InputDecoration(
                      hintText: '输入消息...',
                      border: InputBorder.none,
                    ),
                    onSubmitted: _handleSubmitted,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: () => _handleSubmitted(_textController.text),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
