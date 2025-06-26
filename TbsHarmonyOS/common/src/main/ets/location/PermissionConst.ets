import { Permissions } from '@kit.AbilityKit';

export class PermissionConst {
  static readonly locationPermissions: Array<Permissions> = [
    'ohos.permission.APPROXIMATELY_LOCATION',
    'ohos.permission.LOCATION',
  ];
  static readonly mediaRWPermissions: Array<Permissions> = [
    'ohos.permission.READ_MEDIA',
    'ohos.permission.WRITE_MEDIA'
  ];
  static readonly imageVideoReadPermission: Permissions = 'ohos.permission.READ_IMAGEVIDEO';
  static readonly imageVideoWritePermission: Permissions = 'ohos.permission.WRITE_IMAGEVIDEO';
  static readonly cameraPermission: Permissions = 'ohos.permission.CAMERA';
  // 获取OAID
  static readonly oaIdPermission: Permissions = 'ohos.permission.APP_TRACKING_CONSENT';
}