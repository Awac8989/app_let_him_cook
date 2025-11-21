class User {
  final String id;
  final String email;
  final String username;
  final String? displayName;
  final String? profileImageUrl;
  final String? bio;
  final DateTime createdAt;
  final DateTime lastActiveAt;
  final List<String> favoriteRecipeIds;
  final List<String> myRecipeIds;
  final int followerCount;
  final int followingCount;
  final bool isEmailVerified;

  User({
    required this.id,
    required this.email,
    required this.username,
    this.displayName,
    this.profileImageUrl,
    this.bio,
    required this.createdAt,
    required this.lastActiveAt,
    this.favoriteRecipeIds = const [],
    this.myRecipeIds = const [],
    this.followerCount = 0,
    this.followingCount = 0,
    this.isEmailVerified = false,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] ?? '',
      email: json['email'] ?? '',
      username: json['username'] ?? '',
      displayName: json['displayName'],
      profileImageUrl: json['profileImageUrl'],
      bio: json['bio'],
      createdAt: DateTime.parse(json['createdAt'] ?? DateTime.now().toIso8601String()),
      lastActiveAt: DateTime.parse(json['lastActiveAt'] ?? DateTime.now().toIso8601String()),
      favoriteRecipeIds: List<String>.from(json['favoriteRecipeIds'] ?? []),
      myRecipeIds: List<String>.from(json['myRecipeIds'] ?? []),
      followerCount: json['followerCount'] ?? 0,
      followingCount: json['followingCount'] ?? 0,
      isEmailVerified: json['isEmailVerified'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'username': username,
      'displayName': displayName,
      'profileImageUrl': profileImageUrl,
      'bio': bio,
      'createdAt': createdAt.toIso8601String(),
      'lastActiveAt': lastActiveAt.toIso8601String(),
      'favoriteRecipeIds': favoriteRecipeIds,
      'myRecipeIds': myRecipeIds,
      'followerCount': followerCount,
      'followingCount': followingCount,
      'isEmailVerified': isEmailVerified,
    };
  }

  User copyWith({
    String? id,
    String? email,
    String? username,
    String? displayName,
    String? profileImageUrl,
    String? bio,
    DateTime? createdAt,
    DateTime? lastActiveAt,
    List<String>? favoriteRecipeIds,
    List<String>? myRecipeIds,
    int? followerCount,
    int? followingCount,
    bool? isEmailVerified,
  }) {
    return User(
      id: id ?? this.id,
      email: email ?? this.email,
      username: username ?? this.username,
      displayName: displayName ?? this.displayName,
      profileImageUrl: profileImageUrl ?? this.profileImageUrl,
      bio: bio ?? this.bio,
      createdAt: createdAt ?? this.createdAt,
      lastActiveAt: lastActiveAt ?? this.lastActiveAt,
      favoriteRecipeIds: favoriteRecipeIds ?? this.favoriteRecipeIds,
      myRecipeIds: myRecipeIds ?? this.myRecipeIds,
      followerCount: followerCount ?? this.followerCount,
      followingCount: followingCount ?? this.followingCount,
      isEmailVerified: isEmailVerified ?? this.isEmailVerified,
    );
  }

  String get displayTitle => displayName ?? username;
}

enum AuthStatus {
  authenticated,
  unauthenticated,
  loading,
}

class AuthState {
  final AuthStatus status;
  final User? user;
  final String? errorMessage;

  const AuthState({
    required this.status,
    this.user,
    this.errorMessage,
  });

  AuthState copyWith({
    AuthStatus? status,
    User? user,
    String? errorMessage,
  }) {
    return AuthState(
      status: status ?? this.status,
      user: user ?? this.user,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  bool get isAuthenticated => status == AuthStatus.authenticated && user != null;
  bool get isLoading => status == AuthStatus.loading;
  bool get isUnauthenticated => status == AuthStatus.unauthenticated;
}