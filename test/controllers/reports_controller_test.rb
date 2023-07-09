require "test_helper"

class ReportsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get reports_url
    assert_response :success
  end

  test "should get report_by_category" do
    get reports_report_by_category_url
    assert_response :success
  end

  test "should get report_by_dates" do
    get reports_report_by_dates_url
    assert_response :success
  end

  test "should get report_by_category with correct expenses h1" do
    get reports_report_by_category_url, params: {operation: {cashflow: "Витрати"}}
    assert_select "h1", "Звіт в розрізі категорій: Витрати"
  end

  test "should get report_by_category with correct income h1" do
    get reports_report_by_category_url, params: {operation: {cashflow: "Доходи"}}
    assert_select "h1", "Звіт в розрізі категорій: Доходи"
  end

  test "should get report_by_dates with correct h1 value" do
    get reports_report_by_dates_url, params: {operation: {cashflow: operations(:food1).cashflow}}
    assert_select "h1", "Динаміка по датах: #{operations(:food1).cashflow}"
  end
end
