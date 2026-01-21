//
//  RCTPlayerView.m
//  Demo2
//
//  Created by Mohd Imran on 20/01/26.
//

#import <Foundation/Foundation.h>
#import "RCTPlayerView.h"
#import "VideoView.h"
#import <react/renderer/components/AppSpec/ComponentDescriptors.h>
#import <react/renderer/components/AppSpec/EventEmitters.h>
#import <react/renderer/components/AppSpec/Props.h>
#import <react/renderer/components/AppSpec/RCTComponentViewHelpers.h>
#import <React-RCTAppDelegate/RCTAppDelegate.h>



using namespace facebook::react;

@interface RCTPlayerView () <RCTCustomPlayerViewViewProtocol>
@property (nonatomic, strong) VideoView *containerView;
@end

@implementation RCTPlayerView {
  NSURL * _sourceURL;

}

-(instancetype)init
{
  if(self = [super init]) {
    self.containerView = [VideoView new];
    self.containerView.frame = self.bounds;
    self.containerView.autoresizingMask =
      UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self addSubview:self.containerView];
  }
  return self;
}

- (void)updateProps:(Props::Shared const &)props oldProps:(Props::Shared const &)oldProps
{
  const auto &oldViewProps = *std::static_pointer_cast<CustomPlayerViewProps const>(_props);
  const auto &newViewProps = *std::static_pointer_cast<CustomPlayerViewProps const>(props);

  // Handle your props here
  if (oldViewProps.sourceURL != newViewProps.sourceURL) {
    NSString *urlString = [NSString stringWithCString:newViewProps.sourceURL.c_str() encoding:NSUTF8StringEncoding];
    _sourceURL = [NSURL URLWithString:urlString];
    [self.containerView setUpUrl:urlString];
    /*if ([self urlIsValid:newViewProps.sourceURL]) {
      [_webView loadRequest:[NSURLRequest requestWithURL:_sourceURL]];
    }*/
  }

  [super updateProps:props oldProps:oldProps];
}

-(void)layoutSubviews
{
  [super layoutSubviews];
  NSLog(@"layoutSubviews is ::: %@", NSStringFromCGRect(self.bounds));
  self.containerView.frame = self.bounds;

}

#pragma mark - WKNavigationDelegate

+ (ComponentDescriptorProvider)componentDescriptorProvider
{
  return concreteComponentDescriptorProvider<CustomPlayerViewComponentDescriptor>();
}

@end

