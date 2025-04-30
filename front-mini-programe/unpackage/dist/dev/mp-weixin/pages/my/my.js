"use strict";
const common_vendor = require("../../common/vendor.js");
const common_assets = require("../../common/assets.js");
const utils_api_marble = require("../../utils/api/marble.js");
require("../../utils/request.js");
require("../../store/user.js");
require("../../utils/token.js");
const __default__ = {
  onShareAppMessage() {
    return {
      title: "科石",
      path: "/pages/home/home"
    };
  },
  onShareTimeline() {
    return {
      title: "科石"
    };
  }
};
const _sfc_main = /* @__PURE__ */ Object.assign(__default__, {
  __name: "my",
  setup(__props) {
    common_vendor.onMounted(() => {
      getStoreList();
    });
    const storeList = common_vendor.ref([]);
    const getStoreList = async () => {
      let { data: res } = await utils_api_marble.requestStoreList();
      if (res.code == 0) {
        storeList.value = res.data.store_infos.map((item) => {
          const phones = item.phone.split("/").filter((p) => p.trim());
          return {
            ...item,
            phones: phones.length > 0 ? phones : ["暂无号码"]
          };
        });
      }
    };
    const makePhoneCall = (phoneNumber) => {
      if (!phoneNumber || phoneNumber === "暂无号码") {
        common_vendor.index.showToast({
          title: "无效的电话号码",
          icon: "none"
        });
        return;
      }
      common_vendor.wx$1.makePhoneCall({
        phoneNumber
      });
    };
    return (_ctx, _cache) => {
      return {
        a: common_vendor.f(storeList.value, (address, k0, i0) => {
          return {
            a: common_vendor.t(address.name),
            b: common_vendor.t(address.address),
            c: common_vendor.f(address.phones, (phone, index, i1) => {
              return common_vendor.e({
                a: common_vendor.t(phone),
                b: index < address.phones.length - 1
              }, index < address.phones.length - 1 ? {} : {}, {
                c: index,
                d: common_vendor.o(($event) => makePhoneCall(phone), index)
              });
            }),
            d: address.name
          };
        }),
        b: common_assets._imports_0,
        c: common_assets._imports_1,
        d: _ctx.scrollTop
      };
    };
  }
});
const MiniProgramPage = /* @__PURE__ */ common_vendor._export_sfc(_sfc_main, [["__file", "/Users/hy-harmonyos/Desktop/Lucy-folder/code/HarmonyOS-groundhog-marble-system/front-mini-programe/pages/my/my.vue"]]);
_sfc_main.__runtimeHooks = 6;
wx.createPage(MiniProgramPage);
