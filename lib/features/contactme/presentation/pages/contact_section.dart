import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:html' as html; // ← مهم للويب

class ContactMeSection extends StatefulWidget {
  const ContactMeSection({Key? key}) : super(key: key);

  @override
  State<ContactMeSection> createState() => _ContactMeSectionState();
}

class _ContactMeSectionState extends State<ContactMeSection> {
  Map<String, dynamic>? _profileData;

  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _serviceController = TextEditingController();
  final _timelineController = TextEditingController();
  final _detailsController = TextEditingController();

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    final jsonString = await DefaultAssetBundle.of(
      context,
    ).loadString('assets/cv_info.json');
    setState(() {
      _profileData = json.decode(jsonString);
    });
  }

  Future<void> _sendEmail() async {
    if (!_formKey.currentState!.validate()) return;

    final myEmail = _profileData?['email'];
    if (myEmail == null) return;

    final subject = Uri.encodeComponent('New Project Inquiry');
    final body = Uri.encodeComponent('''
Name: ${_nameController.text}
Email: ${_emailController.text}
Phone: ${_phoneController.text}
Service: ${_serviceController.text}
Timeline: ${_timelineController.text}

Project Details:
${_detailsController.text}
''');

    final mailUrl = 'mailto:$myEmail?subject=$subject&body=$body';

    if (kIsWeb) {
      final anchor = html.AnchorElement(href: mailUrl);
      anchor.target = '_blank';
      anchor.click();
    } else {
      final uri = Uri.parse(mailUrl);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Could not open email app')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.of(context).size.width > 700;
    final myEmail = _profileData?['email'] ?? 'example@email.com';
    final myNumber = _profileData?['phone_number'] ?? '+201000000000';

    final inputDecoration = InputDecoration(
      filled: true,
      fillColor: const Color(0xFF1A1A1A),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide.none,
      ),
      hintStyle: const TextStyle(color: Colors.white54),
    );

    Widget buildRow(List<Widget> children) {
      if (isWide) {
        return Row(
          children: [
            for (int i = 0; i < children.length; i++) ...[
              Expanded(child: children[i]),
              if (i < children.length - 1) const SizedBox(width: 16),
            ],
          ],
        );
      } else {
        return Column(
          children: [
            for (int i = 0; i < children.length; i++) ...[
              children[i],
              if (i < children.length - 1) const SizedBox(height: 16),
            ],
          ],
        );
      }
    }

    return Container(
      color: Colors.black,
      padding: const EdgeInsets.all(24),
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                "Contact me",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                "Cultivating Connections: Reach Out And Connect With Me",
                style: TextStyle(color: Colors.white54),
              ),
              const SizedBox(height: 24),

              Form(
                key: _formKey,
                child: Column(
                  children: [
                    buildRow([
                      TextFormField(
                        controller: _nameController,
                        decoration: inputDecoration.copyWith(hintText: "Name"),
                        style: const TextStyle(color: Colors.white),
                        validator: (v) => v!.isEmpty ? 'Required' : null,
                      ),
                      TextFormField(
                        controller: _emailController,
                        decoration: inputDecoration.copyWith(hintText: "Email"),
                        style: const TextStyle(color: Colors.white),
                        validator: (v) => v!.isEmpty ? 'Required' : null,
                      ),
                    ]),
                    const SizedBox(height: 16),

                    buildRow([
                      TextFormField(
                        controller: _phoneController,
                        decoration: inputDecoration.copyWith(
                          hintText: "Phone Number",
                        ),
                        style: const TextStyle(color: Colors.white),
                      ),
                      TextFormField(
                        controller: _serviceController,
                        decoration: inputDecoration.copyWith(
                          hintText: "Service Of Interest",
                        ),
                        style: const TextStyle(color: Colors.white),
                      ),
                    ]),
                    const SizedBox(height: 16),

                    buildRow([
                      TextFormField(
                        controller: _timelineController,
                        decoration: inputDecoration.copyWith(
                          hintText: "Timeline",
                        ),
                        style: const TextStyle(color: Colors.white),
                      ),
                      TextFormField(
                        controller: _detailsController,
                        decoration: inputDecoration.copyWith(
                          hintText: "Project Details...",
                        ),
                        style: const TextStyle(color: Colors.white),
                        maxLines: isWide ? 4 : 5,
                      ),
                    ]),
                    const SizedBox(height: 24),

                    Align(
                      alignment:
                          isWide ? Alignment.centerRight : Alignment.center,
                      child: ElevatedButton(
                        onPressed: _sendEmail,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF1A1A1A),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 40,
                            vertical: 14,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                            side: const BorderSide(color: Colors.white24),
                          ),
                        ),
                        child: const Text("Send"),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 40),
              const Divider(color: Colors.white24),

              // 📩 الإيميل ورقم الواتساب
              const SizedBox(height: 20),
              if (isWide)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildContactItem(Icons.email, myEmail),
                    const SizedBox(width: 40),
                    _buildContactItem(FontAwesomeIcons.phone, myNumber),
                  ],
                )
              else
                Column(
                  children: [
                    _buildContactItem(Icons.email, myEmail),
                    const SizedBox(height: 12),
                    _buildContactItem(FontAwesomeIcons.phone, myNumber),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContactItem(IconData icon, String text) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: Colors.grey),
        const SizedBox(width: 8),
        SelectableText(
          text,
          style: const TextStyle(color: Colors.white70, fontSize: 16),
        ),
      ],
    );
  }
}
