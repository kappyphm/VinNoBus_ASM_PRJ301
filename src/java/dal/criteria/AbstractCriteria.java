package dal.criteria;

/**
 * AbstractCriteria ----------------- Lớp cha trừu tượng cho tất cả tiêu chí
 * truy vấn. Cung cấp khả năng phân trang, sắp xếp, và build điều kiện động.
 *
 * Tất cả Criteria con (như UserCriteria, ProductCriteria, ...) sẽ kế thừa lớp
 * này.
 */
public abstract class AbstractCriteria {

    // --- Pagination ---
    protected int page = 1;
    protected int pageSize = 10;

    // --- Sorting ---
    protected String sortBy = "id";
    protected String sortDirection = "ASC"; // hoặc "DESC"

    // --- Common helper ---
    public int getOffset() {
        return (page - 1) * pageSize;
    }

    public int getLimit() {
        return pageSize;
    }

    // --- Abstract methods ---
    /**
     * Trả về chuỗi SQL điều kiện WHERE (ví dụ: "AND email LIKE ? AND role_id =
     * ?")
     */
    public abstract String buildWhereClause();

    /**
     * Trả về danh sách các tham số (Object[]) tương ứng với điều kiện WHERE.
     */
    public abstract Object[] getParams();

    // --- Getter / Setter ---
    public int getPage() {
        return page;
    }

    public void setPage(int page) {
        this.page = page;
    }

    public int getPageSize() {
        return pageSize;
    }

    public void setPageSize(int pageSize) {
        this.pageSize = pageSize;
    }

    public String getSortBy() {
        return sortBy;
    }

    public void setSortBy(String sortBy) {
        this.sortBy = sortBy;
    }

    public String getSortDirection() {
        return sortDirection;
    }

    public void setSortDirection(String sortDirection) {
        this.sortDirection = sortDirection;
    }
}
