//
//  ViewController.m
//  UIImageViewWithLoupe
//
//  Created by Salmo Roberto da Silva Junior on 12/2/13.
//
//

#import "ViewController.h"

#define imgLoupeTag 101.0f
#define imgViewTag 100.0f

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UIImageView* imgv=(UIImageView*) [self.view viewWithTag:imgViewTag];
    UITouch* touch=[touches anyObject];
    
    if (touch.view==imgv) {
        UIImageView* imageViewZoom=[[UIImageView alloc] initWithFrame:CGRectMake(60, 200, 200, 200)];
        [imageViewZoom setTag:imgLoupeTag];
        [self.view addSubview:imageViewZoom];
    }
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    UIImageView* imgv=(UIImageView*) [self.view viewWithTag:imgViewTag];
    UITouch* touch=[touches anyObject];
    
    if (touch.view ==imgv) {
        CGFloat widthScale = imgv.bounds.size.width / imgv.image.size.width;
        CGFloat heightScale = imgv.bounds.size.height / imgv.image.size.height;
        CGFloat blkW=50/widthScale;
        CGFloat blkH=50/heightScale;
        
        CGPoint p= [touch locationInView:imgv];

        float x=p.x/widthScale;
        float y=p.y/heightScale;

        if (x < (blkW/2)) x=blkW/2;
        if (y < (blkH/2)) y=blkH/2;
        if (x > [imgv bounds].size.width/widthScale - (blkW/2)) x=[imgv bounds].size.width/widthScale - (blkW/2);
        if (y > [imgv bounds].size.height/heightScale - (blkH/2)) y=[imgv bounds].size.height/heightScale - (blkH/2);

        CGRect rect=CGRectMake((x-(blkW/2)), (y-(blkH/2)), blkW, blkH);
        
        CGImageRef imageRef = CGImageCreateWithImageInRect([imgv.image CGImage], rect);
        UIImage *img = [UIImage imageWithCGImage:imageRef];
        CGImageRelease(imageRef);
        
        UIImageView* imageViewZoom=(UIImageView*) [self.view viewWithTag:imgLoupeTag];
        [imageViewZoom setImage:img];
    }
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    for (UIView *subView in self.view.subviews) {
        if (subView.tag == imgLoupeTag) {
            [subView removeFromSuperview];
        }
    }
}

@end
