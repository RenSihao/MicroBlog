//
//  BaseTableViewCell.m
//  CherryBlossomAddressBook
//
//  Created by RenSihao on 16/4/8.
//  Copyright © 2016年 XuJiajia. All rights reserved.
//

#import "BaseTableViewCell.h"

@interface CustomSeperatorBgView ()

@property(nonatomic,assign) BaseTableViewCell *cell;
@end

@implementation CustomSeperatorBgView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        _seperatorLineStyle = TableViewCellContinousLine;
        self.seperatorColor = kColorHairline;
        self.backgroundColor =[UIColor clearColor];
        _drawSeperatorLine = YES;
        _drawHeadLine = NO;
        _separatorLineInset = 0;
        _separatorLineWidth = 1;
        _separatorLineTailInset = 0;
    }
    return self;
}
- (void)setFrame:(CGRect)frame
{
    frame.size.width = SCREEN_WIDTH;
    [super setFrame:frame];
}

-(void)drawRect:(CGRect)rect{
    CGContextRef context = UIGraphicsGetCurrentContext();
    if (context) {
        CGContextClearRect(context, rect);
        CGContextSetFillColorWithColor(context, self.backgroundColor.CGColor);
        CGContextFillRect(context, rect);
        
        CGContextSetStrokeColorWithColor(context, _seperatorColor.CGColor);
        CGContextSetLineWidth(context, _separatorLineWidth);
        
        if (self.drawSeperatorLine) {
            if (_seperatorLineStyle == TableViewCellContinousLine) {
                CGContextSaveGState(context);
                CGContextBeginPath(context);
                CGContextMoveToPoint(context, _separatorLineInset, self.bounds.size.height);
                CGContextAddLineToPoint(context, self.bounds.size.width-_separatorLineTailInset, self.bounds.size.height);
                CGContextClosePath(context);
                CGContextStrokePath(context);
                CGContextRestoreGState(context);
            }else if(_seperatorLineStyle == TableViewCellDashedLine){
                CGFloat dashes[] = {2.0, 2.0};
                CGContextSetLineDash(context, 0, dashes, 2);
                CGContextMoveToPoint(context, _separatorLineInset, self.bounds.size.height);
                CGContextAddLineToPoint(context, self.bounds.size.width-_separatorLineTailInset, self.bounds.size.height-1);
                CGContextStrokePath(context);
            }
        }
        if (_drawHeadLine) {
            CGContextMoveToPoint(context, 0, 0);
            CGContextAddLineToPoint(context, self.bounds.size.width, 0);
            CGContextStrokePath(context);
        }
        [self drawOther:rect context:context];
    }
}

-(void)drawOther:(CGRect)rect context:(CGContextRef)context{
    if ([self.cell respondsToSelector:@selector(drawOther:context:)]) {
        [self.cell drawOther:rect context:context];
    }
}


@end


@interface BaseTableViewCell ()

@end

@implementation BaseTableViewCell

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self customInit];
        [self addAllSubViews];
    }
    return self;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self customInit];
        [self addAllSubViews];
    }
    
    return self;
}
- (void)addAllSubViews
{
    
}
-(void) customInit
{
    UIView *selectedBgView = [[UIView alloc] initWithFrame:self.frame];
    _selectedBgColor = kColorCellBgSel;
    selectedBgView.backgroundColor = self.selectedBgColor;
    self.selectedBackgroundView = selectedBgView;
    _drawHeadLine = NO;
    _drawSeperatorLine = YES;
    _separatorLineInset = 0;
    _separatorLineTailInset = 0;
    CustomSeperatorBgView *bgView = [[CustomSeperatorBgView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    self.bgView.drawSeperatorLine = YES;
    self.bgView.seperatorLineStyle = TableViewCellContinousLine;
    bgView.cell = self;
    self.textLabel.backgroundColor = [UIColor clearColor];
    self.detailTextLabel.backgroundColor = [UIColor clearColor];
    self.backgroundView = bgView;
    self.backgroundColor = kColorBgMain;
}

-(void)setDrawHeadLine:(BOOL)drawHeadLine{
    _drawHeadLine = drawHeadLine;
    self.bgView.drawHeadLine = drawHeadLine;
}

- (void)setSeparatorLineWidth:(CGFloat)separatorLineWidth{
    self.bgView.separatorLineWidth = separatorLineWidth;
}

- (void)setSeparatorLineInset:(CGFloat)separatorLineInset{
    _separatorLineInset = separatorLineInset;
    self.bgView.separatorLineInset = separatorLineInset;
    self.bgView.drawSeperatorLine = YES;
}

- (void)setSeparatorLineTailInset:(CGFloat)separatorLineTailInset{
    _separatorLineTailInset = separatorLineTailInset;
    self.bgView.separatorLineTailInset = separatorLineTailInset;
    self.bgView.drawSeperatorLine = YES;
}

-(void)setDrawSeperatorLine:(BOOL)drawSeperatorLine{
    _drawSeperatorLine = drawSeperatorLine;
    if ([self.bgView isKindOfClass:[CustomSeperatorBgView class]]) {
        self.bgView.drawSeperatorLine = drawSeperatorLine;
        [self.bgView setNeedsDisplay];
    }
}

- (void)setBackgroundColor:(UIColor *)backgroundColor{
    [super setBackgroundColor:backgroundColor];
    self.backgroundView.backgroundColor = backgroundColor;
}

-(void)setSelectedBgColor:(UIColor *)selectedBgColor{
    _selectedBgColor = selectedBgColor;
    self.selectedBackgroundView.backgroundColor = selectedBgColor;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.bgView.frame = self.bounds;
    [self.bgView setNeedsDisplay];
}

-(CustomSeperatorBgView *)bgView{
    return (CustomSeperatorBgView *)self.backgroundView;
}

-(void)drawOther:(CGRect)rect context:(CGContextRef)context{
    
}
@end
