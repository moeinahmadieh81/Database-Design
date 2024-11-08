CREATE TABLE Products (
	ProductId char(12) not null primary key,
    ProductName nvarchar(100) not null,
    ProductCount int not null,
    ProductWeight float not null,
	ModelId int,
	ProductBrand int,
    CompanyId int,
	foreign key(ProductBrand) references Brands(BrandId),
    foreign key(ModelId) references Model(ModelId),
    foreign key(CompanyId) references Company(CompanyId)
);
    
create table Brands(
	BrandId int not null auto_increment primary key,
	BrandName char(50) not null unique,
    EstablishDate date not null
);

create table Model(
	ModelId int not null primary key auto_increment,
	ModelName char(50) not null unique
);

create table Company(
	CompanyId int not null auto_increment primary key,
	CompanyName char(50) not null unique,
    EstablishDate date not null,
    CompanyNumber char(18) not null unique,
    RepoAddress nvarchar(500) not null
);

create table Suppliers(
	SupplierId int not null auto_increment primary key,
    SupplierName char(50) not null unique,
    SupplierEmail nvarchar(200) not null,
    SupplierAddress nvarchar(500) not null,
    WorkHour nvarchar(50) not null
);

create table Customers(
	NationalCode char(10) not null unique primary key,
    FirstName nvarchar(100) not null,
    LastName nvarchar(100) not null,
	PhoneNumber CHAR(11) NOT NULL,
    Province NVARCHAR(50) NOT NULL,
    City NVARCHAR(50) NOT NULL,
    Street NVARCHAR(50) NOT NULL
);

create table Orders(
	OrderId int not null auto_increment primary key,
    OrderDate date not null,
    CustomerId char(10),
	ProductId char(12),
	FOREIGN KEY(ProductId) REFERENCES Products(ProductId),
    FOREIGN KEY(CustomerId) REFERENCES Customers(NationalCode)
);

create table product_supplier(
	Id int not null primary key auto_increment,
    NumberOfProducts int not null,
    ProductId char(12),
    SupplierId int,
    foreign key(ProductId) references Products(ProductId),
    foreign key(SupplierId) references Suppliers(SupplierId)
    );

create table product_orders(
	Id int not null primary key auto_increment,
    OrderId int,
    ProductId char(12),
    SupplierId int,
    NumberOfProducts int not null,
    foreign key(OrderId) references Orders(OrderId),
    foreign key (ProductId) references Products(ProductId)
);