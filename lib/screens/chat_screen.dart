import 'package:chat_firebase/cubits/chat_cubit/chat_cubit.dart';
import 'package:chat_firebase/cubits/chat_cubit/chat_state.dart';
import 'package:chat_firebase/models/message_model.dart';
import 'package:chat_firebase/widgets/chat_bubble.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatScreen extends StatelessWidget {
  ChatScreen({super.key});

  static String id = 'ChatScreen';

  TextEditingController messageController = TextEditingController();
  final controller = ScrollController();
  List<MessageModel> messagesList=[];

  @override
  Widget build(BuildContext context) {
    var email = ModalRoute.of(context)!.settings.arguments;
    //
    // return StreamBuilder<QuerySnapshot>(
    //   //QuerySnapshot
    //   // future: messages.doc('vfPfuXwJ73cW15BQbsEq').get(),       //DocumentSnapshot
    //   stream: messages.orderBy('createdAt', descending: true).snapshots(),
    //   //QuerySnapshot
    //   builder: (context, snapshot) {
    //     //   print(snapshot.data!['message']);                       //DocumentSnapshot
    //     if (snapshot.hasData) {
    //       //    print(snapshot.data!.docs[1]['message']);               //QuerySnapshot
    //       List<MessageModel> messagesList = [];
    //       for (int i = 0; i < snapshot.data!.docs.length; i++) {
    //         messagesList.add(MessageModel.fromJson(snapshot.data!.docs[i]));
    //       }
          return Scaffold(
            appBar: AppBar(
              backgroundColor: const Color(0xff2B475E),
              automaticallyImplyLeading: false,
              title: const Text('Chat'),
              centerTitle: true,
            ),
            body: Column(
              children: [
                Expanded(
                  child: BlocBuilder<ChatCubit,ChatState>(
                    builder: (context, state) {
                      var messagesList = BlocProvider.of<ChatCubit>(context).messagesList;
                      return ListView.builder(
                          reverse: true,
                          physics: const BouncingScrollPhysics(),
                          controller: controller,
                          itemCount: messagesList.length,
                          itemBuilder: (context, index) {
                            return messagesList[index] == email
                                ? ChatBubble(
                              message: messagesList[index],
                            )
                                : ChatBubbleForFriend(message: messagesList[index]);
                          });
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextField(
                    controller: messageController,
                    onSubmitted: (data) {
                      BlocProvider.of<ChatCubit>(context).sendMessage(
                          message: data,
                          email: email.toString(),
                      );
                      messageController.clear();
                      controller.animateTo(
                        0,
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeIn,
                      );
                    },
                    decoration: InputDecoration(
                      hintText: 'Send message',
                      suffixIcon: const Icon(
                        Icons.send,
                        color: Color(0xff2B475E),
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16)),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: const BorderSide(
                          color: Color(0xff2B475E),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: const BorderSide(
                          color: Color(0xff2B475E),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          );
    //     } else {
    //       return const Center(child: CircularProgressIndicator());
    //     }
    //   },
    // );
  }
}
