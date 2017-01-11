//
//  PhotoGroupTableViewCell.m
//  WeChatImage
//
//  Created by CPZX008 on 17/1/5.
//  Copyright © 2017年 xboker. All rights reserved.
//

#import "PhotoGroupTableViewCell.h"

@interface PhotoGroupTableViewCell()

@property (weak, nonatomic) IBOutlet UIImageView *kindImage;
@property (weak, nonatomic) IBOutlet UILabel *kindName;
@property (weak, nonatomic) IBOutlet UILabel *kindCount;



@end


@implementation PhotoGroupTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}




- (void)displayCellWithDataSource:(NSMutableArray *)dataSource indexPath:(NSIndexPath *)path {
    if (dataSource.count > path.row) {
        NSDictionary *data = dataSource[path.row];
        [self displayCellWithDataSource:data];
    }
}

- (void)displayCellWithDataSource:(NSDictionary *)dataDic {
    __weak PhotoGroupTableViewCell *weakSelf = self;
    PHFetchResult *result = dataDic[@"result"];
    NSString *title = dataDic[@"title"];
    NSString *count = dataDic[@"count"];
    self.kindName.text = title;
    self.kindCount.text = count;
    
    CGSize imageSize = CGSizeMake(100 , 100);
    PHImageRequestOptions *options = [[PHImageRequestOptions alloc] init];
    options.synchronous = YES;
    options.resizeMode = PHImageRequestOptionsResizeModeFast;
    if (result.count > 0) {
        PHAsset *asset = result.firstObject;
        [[PHImageManager defaultManager] requestImageForAsset:asset targetSize:imageSize contentMode:PHImageContentModeAspectFill options:options resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
            weakSelf.kindImage.image = result;
        }];
    }


    
    
    
}






@end
