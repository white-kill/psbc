const {defineConfig} = require('@vue/cli-service')
const path = require("path");

module.exports = defineConfig({
    publicPath: process.env.NODE_ENV === 'production' ? './' : '/', // 开发环境用绝对路径
    outputDir: 'dist',
    assetsDir: 'static',
    indexPath: 'index.html',
    devServer: {
        proxy: {
            '/api': {
                target: 'http://api.jianshewap.cc', // 后端API地址http://47.102.135.129:8001
                changeOrigin: true, // 允许跨域
                pathRewrite: {
                    '^/api': '' // 重写路径，去掉/api前缀
                }
            }
        }
    },
    // 确保正确配置资源路径
    configureWebpack: {
        output: {
            publicPath: process.env.NODE_ENV === 'production' ? '' : '/'
        }
    },
    pluginOptions: {
        'style-resources-loader': {
            preProcessor: 'sass',
        }
    },
})
