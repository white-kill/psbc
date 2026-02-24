class Apis {
  static const login = '/auth/api/login';

  ///用户信息
  static const memberInfo = '/servicepsbc/member/info';

  ///查询明细
  static const detailsQuery = '/servicepsbc/bill/page';

  ///查询收支列表-单个时间查询
  static const billRangePayment = '/servicepsbc/bill/pageRangePayment';

  ///查询收支列表-时间范围查询+关键词
  static const billKeywordPayment = '/servicepsbc/bill/pageKeyWordPayment';

  ///银行列表
  static const bankList = '/servicepsbc/bank/list';

  ///分页查询账单打印申请列表
  static const flowExportApplyPage = '/servicepsbc/flowExport/applyPage';

  ///查询转账列表
  static const transferPage = '/servicepsbc/bill/transferPage';

  ///联系人列表
  static const contactsList = '/servicepsbc/contacts/list';

  ///银行卡转账
  static const billTransfer = '/servicepsbc/bill/transfer';

  ///账单信息打印
  static const flowExportPrint = '/servicepsbc/flowExport/print';

  ///账单信息打印
  static const monthBillList = '/servicepsbc/bill/monthBillList';

  ///分析
  static const billAnalysis = '/servicepsbc/bill/analysis';

  ///收支分析排行列表
  static const incomeAnalysisRank = '/servicepsbc/bill/incomeExpenseRank';

  ///收支分析图表
  static const categoryList = '/servicepsbc/bill/categoryList';

  ///月度账单
  static const monthBill = '/servicepsbc/bill/monthBill';

  ///月度账单
  static const yearSurplus = '/servicepsbc/bill/yearSurplus';

  static const receiptPage = '/servicepsbc/bill/receiptPage';

  static const checkReceipt = '/servicepsbc/bill/checkReceipt';
}
