#import "FlutterCachedMusicPlayerPlugin.h"
#import <flutter_cached_music_player/flutter_cached_music_player-Swift.h>

@implementation FlutterCachedMusicPlayerPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftFlutterCachedMusicPlayerPlugin registerWithRegistrar:registrar];
}
@end
