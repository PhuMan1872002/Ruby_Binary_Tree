# Khai báo cấu trúc cây nhị phân tìm kiếm.
# 1.2. Viết thủ tục khởi tạo cây rỗng.
# 1.3. Viết thủ tục thêm một phần tử vào cây 
# 1.4. Viết thủ tục tìm một phần tử trong cây 
# 1.5. Viết thủ tục xóa một nut trong cây (dùng đệ quy).
# 1.6. Viết thủ tục duyệt cây theo thứ tự NLR (dùng đệ quy)
# 1.7. Viết thủ tục duyệt cây theo thứ tự LNR (dùng đệ quy)
# 1.8. Viết thủ tục duyệt cây theo thứ tự LRN (dùng đệ quy)
# 1.9 Viết thủ tục đếm số phần tử trong cây.
# 1.10 Viết thủ tục tính trung bình cộng các phần tử trong cây.
# 1.11 Viết thủ tục tìm giá trị lớn nhất trong cây.
# 1.12 Viết thủ tục đếm số phần tử là số nguyên tố trong cây.
class Binary_tree 
    # khởi tạo node và link left và right 
    class Node
        attr_accessor :data, :left, :right
        def initialize(value)
            @data = value 
            @left = nil
            @right = nil 
        end
    end
    
    # khởi tạo node root
    attr_accessor :root
    def initialize
        @root = nil
    end

    def add__node(value)
        node = Node.new(value)
        if (@root.nil?) # nếu root chưa có giá trị nào 
            @root = node
            return
        else  # nếu cây đã có danh sách
            nut = @root
            while (true)
                if (value < nut.data) # kiểm tra node trái
                    if (nut.left == nil)
                       nut.left = node
                       return 
                    else
                        nut = nut.left 
                    end
                elsif (value > nut.data) #kiểm tra node phải
                    if (nut.right == nil)
                        nut.right = node
                        return 
                    else
                        nut = nut.right
                    end
                end
            end
        end 
    end
    #hàm xuất giá trị NLR
    def print_NLR(node = self.root)
        if node != nil
            print "#{node.data} "
            print_NLR(node.left)
            print_NLR(node.right)
        end
    end
    #hàm xuất giá trị LNR
    def print_LNR(node = self.root)
        if node != nil
            print_NLR(node.left)
            print "#{node.data} "
            print_NLR(node.right)
        end
    end
    #hàm xuất giá trị LRN
    def print_LRN(node = self.root)
        if node != nil
            print_NLR(node.left)
            print_NLR(node.right)
            print "#{node.data} "
        end
    end


    
    #hàm đếm sô node trong cây 
    def count_node
        @@count = 0
        def count_key(node = self.root)
            if node != nil
                @@count = @@count + 1
                count_key(node.left)
                count_key(node.right)
            end
        end
        count_key
        return @@count 
    end
    
    def count_level
        @@level = 0
        @@count_max = 0
        def do_count_level(node = self.root)
            if node != nil
                @@count_max = @@count_max + 1

                if (@@level < @@count_max)
                    @@level = @@count_max
                end
                do_count_level(node.left)
                do_count_level(node.right)
                @@count_max = @@count_max - 1
            end
        end
        do_count_level
        return @@level
    end

    def sum_key
        @@sum = 0
        def sum_node (node = self.root)
            if node != nil
                @@sum = @@sum + node.data
                sum_node(node.left)
                sum_node(node.right)
            end
        end
        sum_node
        return @@sum
    end

    #xóa key
    def delete_key(value)
        @node = self.root
        if (@node.left == nil && @node.right == nil && @node.data == value) # nếu node root duy nhất
            self.root = nil
            return
        end

        def find_node(value)#hàm tìm node và trả về
            while true
                if (@node.data == value)
                    return @node
                end
                if (value < @node.data)
                    @node = @node.left
                else
                    @node = @node.right
                end
            end
        end
        @node = find_node(value)

        def find_node_max(nut)
            if (nut.right == nil)
                return nut
            end
            nut = nut.right
            find_node_max(nut)
        end


        def find_node_min(nut)
            if (nut.left == nil)
                return nut
            end
            nut = nut.left
            find_node_min(nut)
        end

        def find_node_next_leaf(nut)
            key = self.root
            while true 
                if (key.left == nut)
                    key.left = nil
                    return
                elsif (key.right == nut)
                    key.right = nil
                    return
                end
                if (nut.data < key.data)
                    key = key.left
                else
                    key = key.right
                end
            end
        end

        def delete(key)#ham xóa node de quy
            if (key.left != nil)
                @temp = key
                @temp = find_node_max(@temp = @temp.left) #gọi hàm tìm max bên trái nếu có
                num = @temp.data
                if (@temp.left == nil && @temp.right == nil)
                    find_node_next_leaf(@temp)
                    key.data = num
                else
                    key.data = num
                    delete(@temp)
                end
            elsif (key.right != nil)
                @temp = key 
                @temp =  find_node_min(@temp = @temp.right) #gọi hàm tìm min bên phải
                num = @temp.data
                if (@temp.left == nil && @temp.right == nil)
                    find_node_next_leaf(@temp)
                    key.data = num
                else
                    key.data = num
                    delete(@temp)
                end
            else
                find_node_next_leaf(key)
            end    
        end
        delete(@node)
        return
    end
end
# khởi tạo tree
$tree = Binary_tree.new
# hàm tìm kiếm node trong Binary_tree
def search__node(value)
    if ($tree.root == nil)
        return false
    end
    nut = $tree.root
    while (true)
        if (value == nut.data)
            return true
        end

        if (value < nut.data)
            if (nut.left == nil)
                return false
            end
            nut = nut.left
        else 
            if (nut.right == nil)
                return false
            end
            nut = nut.right
        end
    end
end

def menu 
    puts "################## MENU ###################"
    puts "[1] Nhập danh sách để thêm vào binary tree"
    puts "[2] Xuất danh sách NLR"
    puts "[3] Xuất danh sách LNR"
    puts "[4] Xuất danh sách LRN"
    puts "[5] Tìm một phần tử x trong danh sách"
    puts "[6] Xóa một phần tử x trong danh sách"
    puts "[7] Đếm số node trong cây"
    puts "[8] Đếm số bậc trong cây"
    puts "[9] Tổng node trong cây"
    puts "[10] Thoát"
    print "nhập lựa chọn: "
end

while true
    menu 
    choose = gets.to_i
    while (choose < 1 || choose > 10)
        print "chọn lại: "
        choose = gets.to_i

        break if (choose > 1 && choose < 10)
    end

    system "cls"

    case choose
    when 1
        puts "nhap giá trị '0' để dừng lại"
        while true
            print "put: "
            num = gets.to_i
            break if (num==0)
            if !(search__node(num))
                $tree.add__node(num)
            end
        end
    when 2
        if ($tree.root == nil)
            puts "cây rỗng"
        else
            $tree.print_NLR
            puts ""
        end
    when 3
        if ($tree.root == nil)
            puts "cây rỗng"
        else
            $tree.print_LNR
            puts ""
        end
    when 4
        if ($tree.root == nil)
            puts "cây rỗng"
        else
            $tree.print_LRN
            puts ""
        end
    when 5
        if ($tree.root == nil)
            puts "cây rỗng" 
        else
            print "nhap giá trị muốn tìm: "
            num_x = gets.to_i
            $tree.print_NLR
            puts ""
            if (search__node(num_x))
                puts "tìm thấy giá trị #{num_x} trong cây"
            else
                puts "không tìm thấy giá trị #{num_x} trong cây"
            end
        end
    when 6
        if ($tree.root == nil)
            puts "cây rỗng" 
        else
            $tree.print_NLR
            puts ""
            print "nhập giá trị muốn xóa trong cây "
            num_x = gets.to_i
            if (search__node(num_x))
                $tree.delete_key(num_x)
            else
                puts "#{num_x} không có sẳn trong cây"
            end
            $tree.print_NLR
            puts ""
        end
    when 7 
        if ($tree.root == nil)
            puts "cây rỗng"
        else
            $tree.print_NLR
            puts ""
            puts $tree.count_node
        end
    when 8
        if ($tree.root == nil)
            puts "cây rỗng"
        else
            print "số bậc của cây là "
            puts $tree.count_level
        end
    when 9
        if ($tree.root == nil)
            puts "cây rỗng"
        else
            $tree.print_NLR
            puts ""
            print "tổng các node trong cây là "
            puts $tree.sum_key
        end
    when 10
        break
    end
end














