package kr.co.dendrocopos;

public class EmployeesVO{
	private int employee_id;
	private String first_name;
	private String last_name;
	private String email;
	private String phone_int;
	private float hire_date;
	private String job_id;
	private float salary;
	private float commission_pct;
	private int manager_id;
	private int department_id;
	
	public int getEmployee_id() {
		return employee_id;
	}
	public void setEmployee_id(int employee_id) {
		this.employee_id = employee_id;
	}
	public String getFirst_name() {
		return first_name;
	}
	public void setFirst_name(String first_name) {
		this.first_name = first_name;
	}
	public String getLast_name() {
		return last_name;
	}
	public void setLast_name(String last_name) {
		this.last_name = last_name;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getPhone_int() {
		return phone_int;
	}
	public void setPhone_int(String phone_int) {
		this.phone_int = phone_int;
	}
	public float getHire_date() {
		return hire_date;
	}
	public void setHire_date(float hire_date) {
		this.hire_date = hire_date;
	}
	public String getJob_id() {
		return job_id;
	}
	public void setJob_id(String job_id) {
		this.job_id = job_id;
	}
	public float getSalary() {
		return salary;
	}
	public void setSalary(float salary) {
		this.salary = salary;
	}
	public float getCommission_pct() {
		return commission_pct;
	}
	public void setCommission_pct(float commission_pct) {
		this.commission_pct = commission_pct;
	}
	public int getManager_id() {
		return manager_id;
	}
	public void setManager_id(int manager_id) {
		this.manager_id = manager_id;
	}
	public int getDepartment_id() {
		return department_id;
	}
	public void setDepartment_id(int department_id) {
		this.department_id = department_id;
	}
}
