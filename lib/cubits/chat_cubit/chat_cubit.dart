import 'package:chat_firebase/cubits/chat_cubit/chat_state.dart';
import 'package:chat_firebase/models/message_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitial());

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference messages =
      FirebaseFirestore.instance.collection('messages');

  List<MessageModel> messagesList=[];
  void sendMessage({required String message, required String email}) {
    try {
      messages.add({
        'message': message,
        'createdAt': DateTime.now(),
        'id': email,
      });
    } on Exception catch (e) {}
  }

  void getMessages(){
    messages.orderBy('createdAt', descending: true).snapshots().listen((event){
      messagesList.clear();
      for(var doc in event.docs){
        messagesList.add(MessageModel.fromJson(doc));
      }
      emit(ChatSuccess(messages: messagesList));
    });
  }
}
